import 'package:injector/injector.dart';
import 'package:siteica_user/utils/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_migration_service/sqflite_migration_service.dart';

class DatabaseService {
  final _migrationService =
      Injector.appInstance.get<DatabaseMigrationService>();
  Database _database;

  Future initialise() async {
    _database = await openDatabase(DB_NAME, version: 1);

    await _migrationService.runMigration(
      _database,
      migrationFiles: [
        '1_create_schema.sql',
        '2_create_data_set.sql',
        //'3_create_demo_user.sql',
      ],
      verbose: true,
    );
  }
}
