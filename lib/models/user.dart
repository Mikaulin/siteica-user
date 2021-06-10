import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final int provinceId;
  final String uuid;
  final int deleted;
  final int date;

  User({
    this.id,
    this.provinceId,
    this.uuid,
    this.deleted,
    this.date,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
