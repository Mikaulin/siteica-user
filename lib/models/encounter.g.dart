// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encounter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Encounter _$EncounterFromJson(Map<String, dynamic> json) {
  return Encounter(
    id: json['id'] as int,
    ownSeed: json['ownSeed'] as String,
    encounterSeed: json['encounterSeed'] as String,
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
    date: json['date'] as int,
    distance: (json['distance'] as num)?.toDouble(),
    transmitted: json['transmitted'] as int,
  );
}

Map<String, dynamic> _$EncounterToJson(Encounter instance) => <String, dynamic>{
      'id': instance.id,
      'ownSeed': instance.ownSeed,
      'encounterSeed': instance.encounterSeed,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'date': instance.date,
      'distance': instance.distance,
      'transmitted': instance.transmitted,
    };
