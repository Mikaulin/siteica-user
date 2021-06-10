// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'province.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Province _$ProvinceFromJson(Map<String, dynamic> json) {
  return Province(
    id: json['id'] as int,
    provinceName: json['provinceName'] as String,
    deleted: json['deleted'] as int,
  );
}

Map<String, dynamic> _$ProvinceToJson(Province instance) => <String, dynamic>{
      'id': instance.id,
      'provinceName': instance.provinceName,
      'deleted': instance.deleted,
    };
