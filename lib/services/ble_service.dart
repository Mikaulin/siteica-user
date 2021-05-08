
import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:uuid_enhanced/uuid.dart';


startBroadcast() {
  /// Variables para la emisión vía BLE
  BeaconBroadcast beaconBroadcast = BeaconBroadcast();
  String _uuid = Uuid.randomUuid().toString();

  beaconBroadcast.setUUID(_uuid).setMajorId(1).setMinorId(100).start();
}