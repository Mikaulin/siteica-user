import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:beacons_plugin/beacons_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injector/injector.dart';
import 'package:siteica_user/models/beacon.dart';
import 'package:siteica_user/models/encounter.dart';
import 'package:siteica_user/models/encounter_seed.dart';
import 'package:siteica_user/models/user.dart';
import 'package:siteica_user/services/encounter_seed_service.dart';
import 'package:siteica_user/services/encounter_service.dart';
import 'package:siteica_user/utils/constants.dart';
import 'package:siteica_user/utils/geolocator_util.dart';
import 'package:siteica_user/utils/time_util.dart';
import 'package:uuid_enhanced/uuid.dart';

startBroadcast(User _user) async {
  /// Gestión de semillas de intercambio
  final _encounterSeedService =
      Injector.appInstance.get<EncounterSeedService>();
  EncounterSeed _encounterSeed = await _encounterSeedService.getEncounterSeed(
    _user,
  );

  /// Si es null o está caducada (15 mins en constants)
  /// Creamos nueva semilla y la almacenamos
  if (_encounterSeed == null ||
      timeExceeded(_encounterSeed.date, ENCOUNTER_SEED_EXPIRATION)) {
    _encounterSeed = await _encounterSeedService.addEncounterSeed(_user);
  }

  /// Variables para la emisión vía BLE
  BeaconBroadcast beaconBroadcast = BeaconBroadcast();
  beaconBroadcast
      .setUUID(_encounterSeed.seedUuid)
      .setMajorId(1)
      .setMinorId(100)
      .start();

  print("Start broadcast:  ${_encounterSeed.seedUuid}");

  Timer.periodic(Duration(seconds: 60), (timer) async {
    if (timeExceeded(_encounterSeed.date, ENCOUNTER_SEED_EXPIRATION)) {
      beaconBroadcast.stop();
      _encounterSeed = await _encounterSeedService.addEncounterSeed(_user);
      beaconBroadcast
          .setUUID(_encounterSeed.seedUuid)
          .setMajorId(1)
          .setMinorId(100)
          .start();
      print("Start broadcast again ${_encounterSeed.seedUuid}");
    }
  });
}

startObserver(
  User _user,
  StreamController<String> _streamController,
  EncounterService _encounterService,
  EncounterSeedService _encounterSeedService,
) async {
  /// Mensaje de información sobre permisos de ubicación
  await _showDisclosureMessage();

  /// Asignar el controlador del stream de datos
  BeaconsPlugin.listenToBeacons(_streamController);

  /// Suscripción al stream
  _streamController.stream.listen(
    (data) async {
      print("Beacon $data");
      _addEncounter(data, _user, _encounterService, _encounterSeedService);
    },
    onDone: () {},
    onError: (error) {
      print("Ha ocurrido un error: $error");
    },
  );

  await BeaconsPlugin.runInBackground(true);
  await _startMonitoring();
}

_showDisclosureMessage() async {
  if (Platform.isAndroid) {
    await BeaconsPlugin.setDisclosureDialogMessage(
        title: "Se requieren permisos de localización",
        message:
            "Esta aplicación recopila información de los encuentros cercanos.");

    await BeaconsPlugin.clearDisclosureDialogShowFlag(false);
  }
}

_startMonitoring() async {
  if (Platform.isAndroid) {
    BeaconsPlugin.channel.setMethodCallHandler((call) async {
      if (call.method == 'scannerReady') {
        await BeaconsPlugin.startMonitoring();
      }
    });
  } else if (Platform.isIOS) {
    await BeaconsPlugin.startMonitoring();
  }
}

_addEncounter(
  String _encounterData,
  User _user,
  EncounterService _encounterService,
  EncounterSeedService _encounterSeedService,
) async {
  if (_encounterData.isNotEmpty) {
    print("_encounterData isNotEmpty $_encounterData");
    Position _position = await determinePosition();
    EncounterSeed _encounterSeed =
        await _encounterSeedService.getEncounterSeed(_user);

    Beacon _beacon = Beacon.fromJson(jsonDecode(_encounterData));
    double _distance = double.parse(_beacon.distance);

    print("_addEncounter ${_beacon.uuid} ");
    if (_distance <= ENCOUNTER_MIN_DISTANCE) {
      Encounter _encounter =
          await _encounterService.getEncounterByEncounterSeedUuid(_beacon.uuid);
      if (_encounter == null) {
        print("Encuentro con UUID ${_beacon.uuid} nuevo");
        _encounterService.addEncounter(
          ownSeedId: _encounterSeed.id,
          encounterSeedUuid: _beacon.uuid,
          latitude: _position.latitude,
          longitude: _position.longitude,
          date: DateTime.now().millisecondsSinceEpoch,
          distance: _distance,
        );
      } else {
        print(
            "Encuentro con UUID ${_beacon.uuid} ya existe, duración ${_encounter.duration + 1}");
        _encounterService.updateEncounterDuration(_encounter);
      }
    }
  }
}
