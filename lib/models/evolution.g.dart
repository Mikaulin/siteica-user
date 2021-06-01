// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evolution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Evolution _$EvolutionFromJson(Map<String, dynamic> json) {
  return Evolution(
    id: json['id'] as int,
    totalCases: json['totalCases'] as int,
    date: json['date'] as int,
    deleted: json['deleted'] as int,
  );
}

Map<String, dynamic> _$EvolutionToJson(Evolution instance) => <String, dynamic>{
      'id': instance.id,
      'totalCases': instance.totalCases,
      'date': instance.date,
      'deleted': instance.deleted,
    };
