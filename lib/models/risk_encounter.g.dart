// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'risk_encounter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RiskEncounter _$RiskEncounterFromJson(Map<String, dynamic> json) {
  return RiskEncounter(
    id: json['id'] as int,
    riskSeedUuid: json['riskSeedUuid'] as String,
    encounterSeedUuid: json['encounterSeedUuid'] as String,
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
    date: json['date'] as int,
    duration: json['duration'] as int,
    deleted: json['deleted'] as int,
  );
}

Map<String, dynamic> _$RiskEncounterToJson(RiskEncounter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'riskSeedUuid': instance.riskSeedUuid,
      'encounterSeedUuid': instance.encounterSeedUuid,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'date': instance.date,
      'duration': instance.duration,
      'deleted': instance.deleted,
    };
