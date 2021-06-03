import 'package:siteica_user/utils/constants.dart';
import 'package:siteica_user/models/encounter.dart';
import 'package:sqflite/sqflite.dart';

const String encounterTableName = 'encounter';

class EncounterService {
  Future<List<Encounter>> getEncounters() async {
    Database _database = await openDatabase(DB_NAME, version: 1);

    int _finishTime = DateTime.now().millisecondsSinceEpoch;
    int _startTime = _finishTime - ENCOUNTER_RISK_TIME_PERIOD;

    List<Map> _results = await _database.rawQuery(
        'SELECT * FROM $encounterTableName '
            'WHERE (date >= ? AND date <= ?)',
        [_startTime, _finishTime]);

    return _results.map((e) => Encounter.fromJson(e)).toList();
  }

  Future addEncounter({
    int ownSeedId,
    String encounterSeedUuid,
    double latitude,
    double longitude,
    int date,
    double distance,
    int transmitted = 0,
  }) async {
    Database _database = await openDatabase(DB_NAME, version: 1);

    try {
      await _database.insert(
          encounterTableName,
          Encounter(
            ownSeedId: ownSeedId,
            encounterSeedUuid: encounterSeedUuid,
            latitude: latitude,
            longitude: longitude,
            date: date,
            distance: distance,
            transmitted: transmitted,
            duration: 1,
          ).toJson());
    } catch (e) {
      print('Could not insert the encounter: $e');
    }
  }

  Future<int> updateEncounterDuration(Encounter _encounter) async {
    Database _database = await openDatabase(DB_NAME, version: 1);
    int _duration = _encounter.duration + 1;

    return await _database.rawUpdate(
        'UPDATE $encounterTableName SET duration = ? WHERE id = ?',
        [_duration, _encounter.id]);
  }

  ///Método que busque por semilla
  Future<Encounter> getEncounterByEncounterSeedUuid(String _encounterSeedUuid) async {
    Database _database = await openDatabase(DB_NAME, version: 1);
    List<Map> _results = await _database.rawQuery(
      'SELECT * FROM $encounterTableName WHERE encounterSeedUuid = ? ORDER BY date DESC LIMIT 1',
    [_encounterSeedUuid]);
    List<Encounter> _encounterList =
        _results.map((e) => Encounter.fromJson(e)).toList();

    return _encounterList.isEmpty ? null : _encounterList.first;
  }
}
