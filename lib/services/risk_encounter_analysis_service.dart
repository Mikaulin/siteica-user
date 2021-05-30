import 'package:siteica_user/models/risk_encounter_analysis.dart';
import 'package:siteica_user/utils/constants.dart';
import 'package:sqflite/sqflite.dart';

const String riskEncounterAnalysisTableName = 'risk_encounter_analysis';

class RiskEncounterAnalysisService {
  Future<RiskEncounterAnalysis> getLastRiskEncounterAnalysis() async {
    Database _database = await openDatabase(DB_NAME, version: 1);

    List<Map> _results = await _database.rawQuery(
      'SELECT * FROM $riskEncounterAnalysisTableName ORDER BY date DESC LIMIT 1',
    );
    List<RiskEncounterAnalysis> _analysis =
    _results.map((e) => RiskEncounterAnalysis.fromJson(e)).toList();
    return _analysis.isEmpty ? null : _analysis.first;
  }

  Future addRiskEncounterAnalysis(bool _riskFound) async {
    Database _database = await openDatabase(DB_NAME, version: 1);

    try {
      await _database.insert(
          riskEncounterAnalysisTableName,
          RiskEncounterAnalysis(
            date: DateTime.now().millisecondsSinceEpoch,
            riskFound: _riskFound ? 1 : 0,
            deleted: 0,
          ).toJson());
    } catch (e) {
      print('Could not insert the encounter: $e');
    }
  }
}
