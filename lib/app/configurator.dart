import 'package:injector/injector.dart';
import 'package:siteica_user/services/api_service.dart';
import 'package:siteica_user/services/database_service.dart';
import 'package:siteica_user/services/encounter_seed_service.dart';
import 'package:siteica_user/services/encounter_service.dart';
import 'package:siteica_user/services/evolution_province_service.dart';
import 'package:siteica_user/services/evolution_service.dart';
import 'package:siteica_user/services/private_notification_service.dart';
import 'package:siteica_user/services/province_service.dart';
import 'package:siteica_user/services/risk_encounter_analysis_service.dart';
import 'package:siteica_user/services/risk_encounter_service.dart';
import 'package:siteica_user/services/user_service.dart';
import 'package:sqflite_migration_service/sqflite_migration_service.dart';

final injector = Injector.appInstance;

void setupDependencyInjector() {
  injector.registerDependency<DatabaseMigrationService>(
      () => DatabaseMigrationService());
  injector.registerDependency<DatabaseService>(() => DatabaseService());
  injector.registerDependency<UserService>(() => UserService());
  injector.registerDependency<EncounterService>(() => EncounterService());
  injector
      .registerDependency<EncounterSeedService>(() => EncounterSeedService());
  injector.registerDependency<ProvinceService>(() => ProvinceService());
  injector
      .registerDependency<RiskEncounterService>(() => RiskEncounterService());
  injector.registerDependency<RiskEncounterAnalysisService>(
      () => RiskEncounterAnalysisService());
  injector.registerDependency<PrivateNotificationService>(
      () => PrivateNotificationService());
  injector.registerDependency<ApiService>(() => ApiService());
  injector.registerDependency<EvolutionService>(() => EvolutionService());
  injector.registerDependency<EvolutionProvinceService>(() => EvolutionProvinceService());
}
