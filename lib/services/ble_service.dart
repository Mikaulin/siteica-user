import 'dart:async';

import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:injector/injector.dart';
import 'package:siteica_user/models/encounter_seed.dart';
import 'package:siteica_user/models/user.dart';
import 'package:siteica_user/services/encounter_seed_service.dart';
import 'package:siteica_user/utils/constants.dart';
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
