import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:siteica_user/models/user.dart';
import 'package:siteica_user/services/ble_service.dart';
import 'package:siteica_user/services/encounter_seed_service.dart';
import 'package:siteica_user/services/encounter_service.dart';
import 'package:siteica_user/services/user_service.dart';

class HomePage extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => HomePage(),
      );

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _userService = Injector.appInstance.get<UserService>();
  final _encounterService = Injector.appInstance.get<EncounterService>();
  final _encounterSeedService =
      Injector.appInstance.get<EncounterSeedService>();

  /// Variables for listening
  String _beaconResult = 'Not Scanned Yet.';
  bool _isScanning = false;
  final StreamController<String> beaconEventsController =
      StreamController<String>.broadcast();

  _configureDeviceForBle() async {
    User _user = await _userService.getUser();
    startBroadcast(_user);
    startObserver(
      _user,
      beaconEventsController,
      _beaconResult,
      _isScanning,
      _encounterService,
      _encounterSeedService,
    );
  }

  @override
  void initState() {
    super.initState();
    _configureDeviceForBle();
  }

  @override
  void dispose() {
    beaconEventsController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("*Home test"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('$_beaconResult'),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              Visibility(
                visible: _isScanning,
                child: Text("Escaneando..."),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
