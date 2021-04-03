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
    startDate: json['startDate'] as int,
    endDate: json['endDate'] as int,
    averageDistance: json['averageDistance'] as int,
    transmitted: json['transmitted'] as int,
  );
}

Map<String, dynamic> _$EncounterToJson(Encounter instance) => <String, dynamic>{
      'id': instance.id,
      'ownSeed': instance.ownSeed,
      'encounterSeed': instance.encounterSeed,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'averageDistance': instance.averageDistance,
      'transmitted': instance.transmitted,
    };
