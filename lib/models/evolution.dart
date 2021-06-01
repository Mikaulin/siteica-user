import 'package:json_annotation/json_annotation.dart';

part 'evolution.g.dart';

@JsonSerializable()
class Evolution {
  final int id;
  final int totalCases;
  final int date;
  final int deleted;

  Evolution({
    this.id,
    this.totalCases,
    this.date,
    this.deleted,
  });

  factory Evolution.fromJson(Map<String, dynamic> json) => _$EvolutionFromJson(json);

  Map<String, dynamic> toJson() => _$EvolutionToJson(this);
}