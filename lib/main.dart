import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:siteica_user/app/locator.dart';
import 'package:siteica_user/services/database_service.dart';
import 'package:siteica_user/ui/start.dart';

void main() {
  // Use this static instance

  //https://pub.flutter-io.cn/packages/sqflite_migration_service/example
  //https://github.com/FilledStacks/sqflite_migration/blob/main/example/lib/services/database_service.dart
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _databaseService = Injector.appInstance.get<DatabaseService>();


  @override
  Widget build(BuildContext context) {
    _databaseService.initialise();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.lightGreen,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StartPage(),
    );
  }
}
