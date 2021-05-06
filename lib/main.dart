import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:siteica_user/app/locator.dart';
import 'package:siteica_user/models/user.dart';
import 'package:siteica_user/services/database_service.dart';
import 'package:siteica_user/services/user_service.dart';
import 'package:siteica_user/ui/register.dart';
import 'package:siteica_user/ui/start.dart';
import 'package:siteica_user/ui/common/progress_indicator.dart';


void main() {
  // Use this static instance

  //https://pub.flutter-io.cn/packages/sqflite_migration_service/example
  //https://github.com/FilledStacks/sqflite_migration/blob/main/example/lib/services/database_service.dart
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _userService = Injector.appInstance.get<UserService>();
  final _databaseService = Injector.appInstance.get<DatabaseService>();
  bool _isLoading = true;
  User _user;

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

  @override
  Widget build(BuildContext context) {
    return _isLoading ? CommonProgressIndicator() : MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _user == null ? RegisterPage() : StartPage(),
    );
  }
}
