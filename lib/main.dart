import 'package:flutter/material.dart';
import 'package:siteica_user/app/locator.dart';
import 'package:siteica_user/ui/start.dart';

void main() {
  // Use this static instance

  //https://pub.flutter-io.cn/packages/sqflite_migration_service/example
  //https://github.com/FilledStacks/sqflite_migration/blob/main/example/lib/services/database_service.dart
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StartPage(),
    );
  }
}
