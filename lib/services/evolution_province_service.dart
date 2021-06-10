import 'package:siteica_user/models/evolution_province_total.dart';
import 'package:siteica_user/utils/constants.dart';
import 'package:sqflite/sqflite.dart';

const String evolutionProvinceTableName = 'evolution_province';

class EvolutionProvinceService {
  Future<List<EvolutionProvinceTotal>> getEvolutionProvinceTotals() async {
    Database _database = await openDatabase(DB_NAME, version: 1);

    List<Map> _results = await _database.rawQuery(
      'SELECT e.provinceName, SUM(ep.totalCases) as total '
      'FROM $evolutionProvinceTableName ep, province e '
      'WHERE ep.provinceId = e.id '
      'GROUP BY ep.provinceId',
    );
    return _results.map((e) => EvolutionProvinceTotal.fromJson(e)).toList();
  }
}
