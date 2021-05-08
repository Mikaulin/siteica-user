import 'package:siteica_user/utils/constants.dart';
import 'package:siteica_user/models/province.dart';
import 'package:sqflite/sqflite.dart';

const String provinceTableName = 'province';

class ProvinceService {
  Future<List<Province>> getProvinces() async {
    Database _database = await openDatabase(DB_NAME, version: 1);
    List<Map> results = await _database.query(provinceTableName);

    return results.map((e) => Province.fromJson(e)).toList();
  }
}
