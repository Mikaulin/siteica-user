import 'package:siteica_user/models/user.dart';
import 'package:siteica_user/utils/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid_enhanced/uuid.dart';

const String userTableName = 'user';

class UserService {
  Future<User> getUser() async {
    Database _database = await openDatabase(DB_NAME, version: 1);

    List<Map> _results = await _database
        .rawQuery('SELECT * FROM user WHERE deleted = 0 LIMIT 1');
    List<User> _userList = _results.map((e) => User.fromJson(e)).toList();
    return _userList.isEmpty ? null : _userList.first;
  }

  Future addUser({
    int provinceId,
  }) async {
    Database _database = await openDatabase(DB_NAME, version: 1);
    try {
      await _database.insert(
          userTableName,
          User(
            uuid: Uuid.randomUuid().toString(),
            provinceId: provinceId,
            date: DateTime.now().millisecondsSinceEpoch,
            deleted: 0,
          ).toJson());
    } catch (e) {
      print('Could not insert the user: $e');
    }
  }
}
