import 'package:json_annotation/json_annotation.dart';

part 'private_notification.g.dart';

@JsonSerializable()
class PrivateNotification {
  final int id;
  final int userId;
  final String otpValue;
  final int diagnosticDate;
  final int submittedDate;

  PrivateNotification({
    this.id,
    this.userId,
    this.otpValue,
    this.diagnosticDate,
    this.submittedDate,
  });

  factory PrivateNotification.fromJson(Map<String, dynamic> json) =>
      _$PrivateNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$PrivateNotificationToJson(this);
}
