import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:injector/injector.dart';
import 'package:siteica_user/app/configurator.dart';
import 'package:siteica_user/models/user.dart';
import 'package:siteica_user/services/database_service.dart';
import 'package:siteica_user/services/user_service.dart';
import 'package:siteica_user/ui/start.dart';
import 'package:siteica_user/ui/common/progress_indicator.dart';
import 'package:siteica_user/ui/welcome.dart';

void main() {
  setupDependencyInjector();
  runApp(SiteicaApp());
}

class SiteicaApp extends StatefulWidget {
  @override
  _SiteicaAppState createState() => _SiteicaAppState();
}

class _SiteicaAppState extends State<SiteicaApp> {
  final _userService = Injector.appInstance.get<UserService>();
  final _databaseService = Injector.appInstance.get<DatabaseService>();
  bool _isLoading = true;
  User _user;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CommonProgressIndicator()
        : MaterialApp(
            localizationsDelegates: [GlobalMaterialLocalizations.delegate],
            title: 'Flutter Demo',
            supportedLocales: [
              const Locale('es'),
            ],
            theme: ThemeData(
              primarySwatch: Colors.lightBlue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: _user == null ? WelcomePage() : StartPage(),
          );
  }


  initDatabaseAndGetUser() async {
    await _databaseService.initialise();
    _user = await _userService.getUser();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initDatabaseAndGetUser();
  }
}
