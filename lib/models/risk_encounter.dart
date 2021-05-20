import 'package:json_annotation/json_annotation.dart';

part 'risk_encounter.g.dart';

@JsonSerializable()
class RiskEncounter {
  final int id;
  final String riskSeedUuid;
  final String encounterSeedUuid;
  final double latitude;
  final double longitude;
  final int date;
  final int deleted;

  RiskEncounter({
    this.id,
    this.riskSeedUuid,
    this.encounterSeedUuid,
    this.latitude,
    this.longitude,
    this.date,
    this.deleted,
  });

  factory RiskEncounter.fromJson(Map<String, dynamic> json) =>
      _$RiskEncounterFromJson(json);

  Map<String, dynamic> toJson() => _$RiskEncounterToJson(this);
}
