import 'package:json_annotation/json_annotation.dart';

part 'province.g.dart';

@JsonSerializable()
class Province {
  final int id;
  final String provinceName;
  final int deleted;

  Province({
    this.id,
    this.provinceName,
    this.deleted,
  });

  factory Province.fromJson(Map<String, dynamic> json) => _$ProvinceFromJson(json);

  Map<String, dynamic> toJson() => _$ProvinceToJson(this);
}