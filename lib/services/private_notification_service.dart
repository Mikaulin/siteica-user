import 'package:siteica_user/models/private_notification.dart';
import 'package:siteica_user/models/user.dart';
import 'package:siteica_user/utils/constants.dart';
import 'package:sqflite/sqflite.dart';

const String privateNotificationTableName = 'private_notification';

class PrivateNotificationService {
  Future addPrivateNotification(
      User user, String otpValue, int diagnosticDate) async {
    Database _database = await openDatabase(DB_NAME, version: 1);

    try {
      await _database.insert(
          privateNotificationTableName,
          PrivateNotification(
            userId: user.id,
            otpValue: otpValue,
            diagnosticDate: diagnosticDate,
            submittedDate: DateTime.now().millisecondsSinceEpoch,
          ).toJson());
    } catch (e) {
      print('Could not insert the encounter: $e');
    }
  }

  Future<PrivateNotification> searchPrivateNotificationByOtpValue(User user, String otpValue) async {
    Database _database = await openDatabase(DB_NAME, version: 1);

    List<Map> _results = await _database.rawQuery(
      'SELECT * FROM $privateNotificationTableName WHERE userId = ? AND otpValue = ? LIMIT 1',
      [user.id, otpValue],
    );
    List<PrivateNotification> _notifications =
        _results.map((e) => PrivateNotification.fromJson(e)).toList();
    return _notifications.isEmpty ? null : _notifications.first;
  }
}
