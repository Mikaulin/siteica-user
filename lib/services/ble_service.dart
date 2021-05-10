import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:beacons_plugin/beacons_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injector/injector.dart';
import 'package:siteica_user/models/beacon.dart';
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

  Timer.periodic(Duration(seconds: 60), (timer) async {
    if (timeExceeded(_encounterSeed.date, ENCOUNTER_SEED_EXPIRATION)) {
      _encounterSeed = await _encounterSeedService.addEncounterSeed(_user);
      beaconBroadcast
          .setUUID(_encounterSeed.seedUuid)
          .setMajorId(1)
          .setMinorId(100)
          .start();
      print("New seed ${_encounterSeed.seedUuid}");
    }
  });
}

// Platform messages are asynchronous, so we initialize in an async method.
Future<void> startObserver(
  User _user,
  StreamController<String> _streamController,
  String _beaconResult,
  bool _isScanning,
  EncounterService _encounterService,
  EncounterSeedService _encounterSeedService,
) async {
  // TODO
  // Intentar obtener en cada intercambio
  Position _position = await determinePosition();

  if (Platform.isAndroid) {
    //Prominent disclosure
    await BeaconsPlugin.setDisclosureDialogMessage(
        title: "Need Location Permission",
        message: "This app collects location data to work with beacons.");

    await BeaconsPlugin.clearDisclosureDialogShowFlag(false);
  }

  BeaconsPlugin.listenToBeacons(_streamController);

  //await BeaconsPlugin.addRegion("siteica", _uuidClient);

  _streamController.stream.listen(
    (data) async {
      if (data.isNotEmpty) {
        _position = await determinePosition();
        EncounterSeed _encounterSeed =
            await _encounterSeedService.getEncounterSeed(_user);

        _beaconResult = data;

        Beacon _beacon = Beacon.fromJson(jsonDecode(data));
        _encounterService.addEncounter(
          ownSeedId: _encounterSeed.id,
          encounterSeedUuid: _beacon.uuid,
          latitude: _position.latitude,
          longitude: _position.longitude,
          date: DateTime.now().millisecondsSinceEpoch,
          duration: 0,
        );
        print("Beacon: $data");
      }

      var _list = await _encounterService.getEncounters();
      print("foo");
    },
    onDone: () {},
    onError: (error) {
      print("Error: $error");
    },
  );

  //Send 'true' to run in background
  await BeaconsPlugin.runInBackground(true);

  if (Platform.isAndroid) {
    BeaconsPlugin.channel.setMethodCallHandler((call) async {
      if (call.method == 'scannerReady') {
        await BeaconsPlugin.startMonitoring;

        _isScanning = true;
      }
    });
  } else if (Platform.isIOS) {
    await BeaconsPlugin.startMonitoring;

    _isScanning = true;
  }

  await BeaconsPlugin.startMonitoring;

  _isScanning = true;
}
