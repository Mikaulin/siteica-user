import 'package:siteica_user/models/encounter_seed.dart';
import 'package:siteica_user/models/user.dart';
import 'package:siteica_user/utils/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid_enhanced/uuid.dart';

const String encounterSeedTableName = 'encounter_seed';

class EncounterSeedService {
  Future<EncounterSeed> getEncounterSeed(User _user) async {
    Database _database = await openDatabase(DB_NAME, version: 1);

    List<Map> _results = await _database.rawQuery(
      'SELECT * FROM encounter_seed WHERE userId = ? AND deleted = 0 ORDER BY date DESC LIMIT 1',
      [_user.id],
    );
    List<EncounterSeed> _seeds =
        _results.map((e) => EncounterSeed.fromJson(e)).toList();
    return _seeds.isEmpty ? null : _seeds.first;
  }

  Future<EncounterSeed> addEncounterSeed(User _user) async {
    Database _database = await openDatabase(DB_NAME, version: 1);
    EncounterSeed _encounterSeed = EncounterSeed(
      userId: _user.id,
      seedUuid: Uuid.randomUuid().toString(),
      date: DateTime.now().millisecondsSinceEpoch,
      deleted: 0,
    );

    try {
      await _database.insert(encounterSeedTableName, _encounterSeed.toJson());
      return _encounterSeed;
    } catch (e) {
      print('Could not insert the encounter seed: $e');
      return null;
    }
  }

  Future<List<EncounterSeed>> getEncounterSeeds(User _user) async {
    Database _database = await openDatabase(DB_NAME, version: 1);

    int _finishTime = DateTime.now().millisecondsSinceEpoch;
    int _startTime = _finishTime - ENCOUNTER_RISK_TIME_PERIOD;

    List<Map> _results = await _database.rawQuery(
        'SELECT * FROM encounter_seed '
            'WHERE (date >= ? AND date <= ?) AND userId = ? ',
        [_startTime, _finishTime, _user.id]
    );

    return _results.map((e) => EncounterSeed.fromJson(e)).toList();
  }

  Future<List<EncounterSeed>> getAllEncounterSeeds(User _user) async {
    Database _database = await openDatabase(DB_NAME, version: 1);

    List<Map> _results = await _database.rawQuery(
        'SELECT * FROM encounter_seed '
            'WHERE userId = ? ',
        [_user.id]
    );

    return _results.map((e) => EncounterSeed.fromJson(e)).toList();
  }
}
