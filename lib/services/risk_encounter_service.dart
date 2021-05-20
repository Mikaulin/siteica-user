import 'package:siteica_user/models/encounter_seed.dart';
import 'package:siteica_user/models/user.dart';
import 'package:siteica_user/utils/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:siteica_user/models/risk_encounter.dart';

const String riskEncounterTableName = 'risk_encounter';

class RiskEncounterService {
  Future<List<RiskEncounter>> getRiskEncounters() async {
    Database _database = await openDatabase(DB_NAME, version: 1);

    int _finishTime = DateTime.now().millisecondsSinceEpoch;
    int _startTime = _finishTime - ENCOUNTER_RISK_TIME_PERIOD;

    List<Map> _results = await _database.rawQuery(
      'SELECT * FROM risk_encounter '
          'WHERE (date >= ? AND date <= ?) ',
        [_startTime, _finishTime]
    );

    return _results.map((e) => RiskEncounter.fromJson(e)).toList();
  }

  Future<EncounterSeed> checkSelfRisk(
    User _user,
    List<EncounterSeed> _selfSeeds,
  ) async {
    /// Encuentros de riesgo
    List<RiskEncounter> _riskSeeds = await getRiskEncounters();

    EncounterSeed _riskEncounter;

    _riskSeeds.takeWhile((e) => _riskEncounter == null).forEach((_riskSeed) {
      _riskEncounter = _selfSeeds.firstWhere((_selfSeed) => _riskSeed.encounterSeedUuid == _selfSeed.seedUuid, orElse: () => null);
    });

    ///TODO  Actualizar los registros para marcarlos como ya leídos

    return _riskEncounter;
  }
}
