import 'package:injector/injector.dart';
import 'package:siteica_user/services/database_service.dart';
import 'package:siteica_user/services/encounter_service.dart';
import 'package:sqflite_migration_service/sqflite_migration_service.dart';

final injector = Injector.appInstance;

void setupLocator() {
  injector.registerDependency<DatabaseMigrationService>(
      () => DatabaseMigrationService());
  injector.registerDependency<DatabaseService>(() => DatabaseService());
  injector.registerDependency<EncounterService>(() => EncounterService());
}
