import 'package:json_annotation/json_annotation.dart';

part 'evolution_province.g.dart';

@JsonSerializable()
class EvolutionProvince {
  final int id;
  final int provinceId;
  final int totalCases;
  final int date;
  final int deleted;

  EvolutionProvince({
    this.id,
    this.provinceId,
    this.totalCases,
    this.date,
    this.deleted,
  });

  factory EvolutionProvince.fromJson(Map<String, dynamic> json) => _$EvolutionProvinceFromJson(json);

  Map<String, dynamic> toJson() => _$EvolutionProvinceToJson(this);
}