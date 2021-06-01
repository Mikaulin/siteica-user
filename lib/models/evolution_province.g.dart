// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evolution_province.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EvolutionProvince _$EvolutionProvinceFromJson(Map<String, dynamic> json) {
  return EvolutionProvince(
    id: json['id'] as int,
    provinceId: json['provinceId'] as int,
    totalCases: json['totalCases'] as int,
    date: json['date'] as int,
    deleted: json['deleted'] as int,
  );
}

Map<String, dynamic> _$EvolutionProvinceToJson(EvolutionProvince instance) =>
    <String, dynamic>{
      'id': instance.id,
      'provinceId': instance.provinceId,
      'totalCases': instance.totalCases,
      'date': instance.date,
      'deleted': instance.deleted,
    };
