import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:beacons_plugin/beacons_plugin.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injector/injector.dart';
import 'package:siteica_user/models/beacon.dart';
import 'package:siteica_user/models/encounter.dart';
import 'package:siteica_user/services/ble_service.dart';
import 'package:siteica_user/services/encounter_service.dart';
import 'package:siteica_user/utils/geolocator_util.dart';
import 'package:uuid_enhanced/uuid.dart';

class HomePage extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => HomePage(),
      );

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _encounterService = Injector.appInstance.get<EncounterService>();

  /// Variables for listening
  String _beaconResult = 'Not Scanned Yet.';
  int _nrMessagesReceived = 0;
  var isScanning = false;
  var _uuidClient = Uuid.randomUuid().toString();
  final StreamController<String> beaconEventsController =
      StreamController<String>.broadcast();

  foo() async {
    List<Encounter> encounters = await _encounterService.getEncounters();
    print(encounters);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // TODO
    // Intentar obtener en cada intercambio
    Position _position = await determinePosition();

    startBroadcast();

    if (Platform.isAndroid) {
      //Prominent disclosure
      await BeaconsPlugin.setDisclosureDialogMessage(
          title: "Need Location Permission",
          message: "This app collects location data to work with beacons.");

      await BeaconsPlugin.clearDisclosureDialogShowFlag(false);
    }

    BeaconsPlugin.listenToBeacons(beaconEventsController);

    await BeaconsPlugin.addRegion("siteica", _uuidClient);

    beaconEventsController.stream.listen(
      (data) {
        if (data.isNotEmpty) {
          setState(() {
            _beaconResult = data;
            _nrMessagesReceived++;
          });
          print("Beacons DataReceived: " + data);
          foo();
          //Registrar encuentro
          /// TODO
          /// Testing add and get from DB


          Beacon _beacon = Beacon.fromJson(jsonDecode(data));
          _encounterService.addEncounter(
            ownSeed: _uuidClient,
            encounterSeed: _beacon.uuid,
            latitude: _position.latitude,
            longitude: _position.longitude,
            date: DateTime.now().millisecondsSinceEpoch,
            distance: double.parse(_beacon.distance),
          );
        }
      },
      onDone: () {},
      onError: (error) {
        print("Error: $error");
      },
    );

    //Send 'true' to run in background
    await BeaconsPlugin.runInBackground(true);

    if (Platform.isAndroid) {
      BeaconsPlugin.channel.setMethodCallHandler((call) async {
        if (call.method == 'scannerReady') {
          await BeaconsPlugin.startMonitoring;
          setState(() {
            isScanning = true;
          });
        }
      });
    } else if (Platform.isIOS) {
      await BeaconsPlugin.startMonitoring;
      setState(() {
        isScanning = true;
      });
    }

    await BeaconsPlugin.startMonitoring;
    setState(() {
      isScanning = true;
    });

    if (!mounted) return;
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
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
              Text('$_nrMessagesReceived'),
              SizedBox(
                height: 20.0,
              ),
              Visibility(
                visible: isScanning,
                child: Text("Escaneando..."),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
