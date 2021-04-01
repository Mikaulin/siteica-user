import 'package:beacon_broadcast/beacon_broadcast.dart';
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
  bool _enabled = false;
  BeaconBroadcast beaconBroadcast = BeaconBroadcast();
  String _uuid = Uuid.randomUuid().toString();

  void _startBroadcast() {
    setState(() {
      _enabled = !_enabled;
    });

    if (_enabled) {

      beaconBroadcast
          .setUUID(_uuid)
          .setMajorId(1)
          .setMinorId(100)
          .start();
    } else {
      beaconBroadcast.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("*Home test"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_uuid),
            Text(
              _enabled ? 'Emitiendo' : 'Desconectado',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startBroadcast,
        tooltip: 'Broadcast',
        child: Icon(_enabled ? Icons.bluetooth_disabled : Icons.settings_bluetooth),
      ),
    );
  }
}