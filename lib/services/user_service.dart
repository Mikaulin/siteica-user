import 'package:siteica_user/models/user.dart';
import 'package:siteica_user/utils/constants.dart';
import 'package:sqflite/sqflite.dart';

const String userTableName = 'user';

class UserService {
  Future<User> getUser() async {
    Database _database = await openDatabase(DB_NAME, version: 1);
    //List<Map> results = await _database.query(userTableName);
    List<Map> _results = await _database.rawQuery('SELECT * FROM user WHERE deleted = 0 LIMIT 1');
    List<User> _userList = _results.map((e) => User.fromJson(e)).toList();
    return _userList.isEmpty ? null : _userList.first;

    //return results.map((todo) => User.fromJson(todo)).toList();
  }

  Future addUser({
    String uuid,
    int provinceId,
    int date,
  }) async {
    Database _database = await openDatabase(DB_NAME, version: 1);

    try {
      await _database.insert(
          userTableName,
          User(
            uuid: uuid,
            provinceId: provinceId,
            date: date,
            deleted: 0,
          ).toJson());
    } catch (e) {
      print('Could not insert the user: $e');
    }
  }
}