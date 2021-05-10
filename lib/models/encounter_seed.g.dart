// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encounter_seed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EncounterSeed _$EncounterSeedFromJson(Map<String, dynamic> json) {
  return EncounterSeed(
    id: json['id'] as int,
    userId: json['userId'] as int,
    seedUuid: json['seedUuid'] as String,
    date: json['date'] as int,
    deleted: json['deleted'] as int,
  );
}

Map<String, dynamic> _$EncounterSeedToJson(EncounterSeed instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'seedUuid': instance.seedUuid,
      'date': instance.date,
      'deleted': instance.deleted,
    };
