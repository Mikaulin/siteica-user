import 'dart:async';
import 'dart:io';

import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:beacons_plugin/beacons_plugin.dart';
import 'package:flutter/material.dart';
import 'package:uuid_enhanced/uuid.dart';

class HomePage extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => HomePage(),
      );

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Variables for broadcasting
  bool _enabled = false;
  BeaconBroadcast beaconBroadcast = BeaconBroadcast();
  String _uuid = Uuid.randomUuid().toString();

  /// Variables for listening
  String _beaconResult = 'Not Scanned Yet.';
  int _nrMessagesReceived = 0;
  var isRunning = false;
  var _uuidClient = Uuid.randomUuid().toString();
  final StreamController<String> beaconEventsController =
      StreamController<String>.broadcast();

  void _startBroadcast() {
    setState(() {
      _enabled = !_enabled;
    });

    if (_enabled) {
      beaconBroadcast.setUUID(_uuid).setMajorId(1).setMinorId(100).start();
    } else {
      beaconBroadcast.stop();
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    if (Platform.isAndroid) {
      //Prominent disclosure
      await BeaconsPlugin.setDisclosureDialogMessage(
          title: "Need Location Permission",
          message: "This app collects location data to work with beacons.");

      await BeaconsPlugin.clearDisclosureDialogShowFlag(false);
    }

    BeaconsPlugin.listenToBeacons(beaconEventsController);

    await BeaconsPlugin.addRegion(
        "foo", _uuidClient);

    beaconEventsController.stream.listen(
            (data) {
          if (data.isNotEmpty) {
            setState(() {
              _beaconResult = data;
              _nrMessagesReceived++;
            });
            print("Beacons DataReceived: " + data);
          }
        },
        onDone: () {},
        onError: (error) {
          print("Error: $error");
        });

    //Send 'true' to run in background
    await BeaconsPlugin.runInBackground(true);

    if (Platform.isAndroid) {
      BeaconsPlugin.channel.setMethodCallHandler((call) async {
        if (call.method == 'scannerReady') {
          await BeaconsPlugin.startMonitoring;
          setState(() {
            isRunning = true;
          });
        }
      });
    } else if (Platform.isIOS) {
      await BeaconsPlugin.startMonitoring;
      setState(() {
        isRunning = true;
      });
    }

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
              // Todo
              /// Broadcast test
              Text(_uuid),
              Text(
                _enabled ? 'Emitiendo' : 'Desconectado',
                style: Theme.of(context).textTheme.headline4,
              ),
              // Todo
              /// Client
              Text('$_beaconResult'),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              Text('$_nrMessagesReceived'),
              SizedBox(
                height: 20.0,
              ),
              Visibility(
                visible: isRunning,
                child: RaisedButton(
                  onPressed: () async {
                    if (Platform.isAndroid) {
                      await BeaconsPlugin.stopMonitoring;

                      setState(() {
                        isRunning = false;
                      });
                    }
                  },
                  child: Text('Stop Scanning', style: TextStyle(fontSize: 20)),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Visibility(
                visible: !isRunning,
                child: RaisedButton(
                  onPressed: () async {
                    initPlatformState();
                    await BeaconsPlugin.startMonitoring;

                    setState(() {
                      isRunning = true;
                    });
                  },
                  child: Text('Start Scanning', style: TextStyle(fontSize: 20)),
                ),
              ),
              Text(_uuidClient)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startBroadcast,
        tooltip: 'Broadcast',
        child: Icon(
            _enabled ? Icons.bluetooth_disabled : Icons.settings_bluetooth),
      ),
    );
  }
}
