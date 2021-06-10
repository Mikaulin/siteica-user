// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beacon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Beacon _$BeaconFromJson(Map<String, dynamic> json) {
  return Beacon(
    name: json['name'] as String,
    uuid: json['uuid'] as String,
    macAddress: json['macAddress'] as String,
    major: json['major'] as String,
    minor: json['minor'] as String,
    distance: json['distance'] as String,
    proximity: json['proximity'] as String,
    scanTime: json['scanTime'] as String,
    rssi: json['rssi'] as String,
    txPower: json['txPower'] as String,
  );
}

Map<String, dynamic> _$BeaconToJson(Beacon instance) => <String, dynamic>{
      'name': instance.name,
      'uuid': instance.uuid,
      'macAddress': instance.macAddress,
      'major': instance.major,
      'minor': instance.minor,
      'distance': instance.distance,
      'proximity': instance.proximity,
      'scanTime': instance.scanTime,
      'rssi': instance.rssi,
      'txPower': instance.txPower,
    };
