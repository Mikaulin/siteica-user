// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as int,
    provinceId: json['provinceId'] as int,
    uuid: json['uuid'] as String,
    deleted: json['deleted'] as int,
    date: json['date'] as int,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'provinceId': instance.provinceId,
      'uuid': instance.uuid,
      'deleted': instance.deleted,
      'date': instance.date,
    };
