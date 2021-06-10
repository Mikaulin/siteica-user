import 'package:json_annotation/json_annotation.dart';

part 'risk_encounter_analysis.g.dart';

@JsonSerializable()
class RiskEncounterAnalysis {
  final int id;
  final int date;
  int riskFound;
  int deleted;

  RiskEncounterAnalysis({
    this.id,
    this.date,
    this.riskFound,
    this.deleted,
  });

  factory RiskEncounterAnalysis.fromJson(Map<String, dynamic> json) =>
      _$RiskEncounterAnalysisFromJson(json);

  Map<String, dynamic> toJson() => _$RiskEncounterAnalysisToJson(this);
}
