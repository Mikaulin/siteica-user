// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encounter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Encounter _$EncounterFromJson(Map<String, dynamic> json) {
  return Encounter(
    id: json['id'] as int,
    ownSeedId: json['ownSeedId'] as int,
    encounterSeedUuid: json['encounterSeedUuid'] as String,
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
    date: json['date'] as int,
    distance: (json['distance'] as num)?.toDouble(),
    duration: json['duration'] as int,
    transmitted: json['transmitted'] as int,
  );
}

Map<String, dynamic> _$EncounterToJson(Encounter instance) => <String, dynamic>{
      'id': instance.id,
      'ownSeedId': instance.ownSeedId,
      'encounterSeedUuid': instance.encounterSeedUuid,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'date': instance.date,
      'distance': instance.distance,
      'duration': instance.duration,
      'transmitted': instance.transmitted,
    };
