import 'package:siteica_user/common/constants.dart';
import 'package:siteica_user/models/encounter.dart';
import 'package:sqflite/sqflite.dart';

const String encounterTableName = 'encounter';

class EncounterService {
  Future<List<Encounter>> getEncounters() async {
    Database _database = await openDatabase(DB_NAME, version: 1);
    List<Map> results = await _database.query(encounterTableName);

    return results.map((todo) => Encounter.fromJson(todo)).toList();
  }

  Future addEncounter({
    String ownSeed,
    String encounterSeed,
    double latitude,
    double longitude,
    int startDate,
    int endDate,
    int averageDistance,
    int transmitted,
  }) async {
    Database _database = await openDatabase(DB_NAME, version: 1);

    try {
      await _database.insert(
          encounterTableName,
          Encounter(
            ownSeed: ownSeed,
            encounterSeed: encounterSeed,
            latitude: latitude,
            longitude: longitude,
            startDate: startDate,
            endDate: endDate,
            averageDistance: averageDistance,
            transmitted: transmitted,
          ).toJson());
    } catch (e) {
      print('Could not insert the encounter: $e');
    }
  }
}
