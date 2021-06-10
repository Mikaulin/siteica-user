// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'private_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivateNotification _$PrivateNotificationFromJson(Map<String, dynamic> json) {
  return PrivateNotification(
    id: json['id'] as int,
    userId: json['userId'] as int,
    otpValue: json['otpValue'] as String,
    diagnosticDate: json['diagnosticDate'] as int,
    submittedDate: json['submittedDate'] as int,
  );
}

Map<String, dynamic> _$PrivateNotificationToJson(
        PrivateNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'otpValue': instance.otpValue,
      'diagnosticDate': instance.diagnosticDate,
      'submittedDate': instance.submittedDate,
    };
