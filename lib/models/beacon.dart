import 'package:json_annotation/json_annotation.dart';

part 'beacon.g.dart';

@JsonSerializable()
class Beacon {
  final String name;
  final String uuid;
  final String macAddress;
  final String major;
  final String minor;
  final String distance;
  final String proximity;
  final String scanTime;
  final String rssi;
  final String txPower;

  Beacon({
    this.name,
    this.uuid,
    this.macAddress,
    this.major,
    this.minor,
    this.distance,
    this.proximity,
    this.scanTime,
    this.rssi,
    this.txPower,
  });

  factory Beacon.fromJson(Map<String, dynamic> json) =>
      _$BeaconFromJson(json);

  Map<String, dynamic> toJson() => _$BeaconToJson(this);
}
