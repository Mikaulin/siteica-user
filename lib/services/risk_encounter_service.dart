import 'package:siteica_user/models/encounter_seed.dart';
import 'package:siteica_user/models/user.dart';
import 'package:siteica_user/utils/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:siteica_user/models/risk_encounter.dart';

const String riskEncounterTableName = 'risk_encounter';

class RiskEncounterService {
  Future<List<RiskEncounter>> getAllRiskEncounters() async {
    Database _database = await openDatabase(DB_NAME, version: 1);

    int _finishTime = DateTime.now().millisecondsSinceEpoch;
    int _startTime = _finishTime - ENCOUNTER_RISK_TIME_PERIOD;

    List<Map> _results = await _database.rawQuery(
        'SELECT * FROM risk_encounter '
        'WHERE (date >= ? AND date <= ?) ',
        [_startTime, _finishTime]);

    return _results.map((e) => RiskEncounter.fromJson(e)).toList();
  }

  Future<List<RiskEncounter>> getRiskEncounters() async {
    Database _database = await openDatabase(DB_NAME, version: 1);

    int _finishTime = DateTime.now().millisecondsSinceEpoch;
    int _startTime = _finishTime - ENCOUNTER_RISK_TIME_PERIOD;

    List<Map> _results = await _database.rawQuery(
        'SELECT * FROM risk_encounter '
        'WHERE (date >= ? AND date <= ?) AND deleted = 0',
        [_startTime, _finishTime]);

    return _results.map((e) => RiskEncounter.fromJson(e)).toList();
  }

  Future<List<RiskEncounter>> getSelfEncounterRisk(
    User _user,
    List<EncounterSeed> _myEncounterSeeds,
  ) async {
    List<RiskEncounter> _riskEncounters = await getAllRiskEncounters();
    List<RiskEncounter> _myRiskEncounters = [];
    _myEncounterSeeds.forEach((_myEncounterSeed) {
      List<RiskEncounter> _myRiskEncountersBySeed = _riskEncounters
          .where((_riskEncounter) =>
              _riskEncounter.encounterSeedUuid == _myEncounterSeed.seedUuid)
          .toList();
      _myRiskEncounters.addAll(_myRiskEncountersBySeed);
    });

    return _riskEncounters;
  }

  Future<int> updateRiskEncounter(RiskEncounter _riskEncounter) async {
    Database _database = await openDatabase(DB_NAME, version: 1);

    return await _database.rawUpdate(
        'UPDATE $riskEncounterTableName SET deleted = ? WHERE id = ?',
        [_riskEncounter.deleted, _riskEncounter.id]);
  }
}
