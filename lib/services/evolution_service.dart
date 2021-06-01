import 'package:siteica_user/models/evolution.dart';
import 'package:siteica_user/utils/constants.dart';
import 'package:sqflite/sqflite.dart';

const String evolutionTableName = 'evolution';

class EvolutionService {
  Future<List<Evolution>> getEvolution() async {
    Database _database = await openDatabase(DB_NAME, version: 1);

    int _finishTime = DateTime.now().millisecondsSinceEpoch;
    int _startTime = _finishTime - ENCOUNTER_RISK_TIME_PERIOD;

    List<Map> _results = await _database.rawQuery(
        'SELECT * FROM $evolutionTableName '
            'WHERE (date >= ? AND date <= ?) AND deleted = 0',
        [_startTime, _finishTime]);

    return _results.map((e) => Evolution.fromJson(e)).toList();
  }
}
