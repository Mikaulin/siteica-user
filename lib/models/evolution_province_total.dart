import 'package:json_annotation/json_annotation.dart';

part 'evolution_province_total.g.dart';

@JsonSerializable()
class EvolutionProvinceTotal {
  final String provinceName;
  final int total;

  EvolutionProvinceTotal({
    this.provinceName,
    this.total,
  });

  factory EvolutionProvinceTotal.fromJson(Map<String, dynamic> json) => _$EvolutionProvinceTotalFromJson(json);

  Map<String, dynamic> toJson() => _$EvolutionProvinceTotalToJson(this);
}