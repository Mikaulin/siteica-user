// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'risk_encounter_analysis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RiskEncounterAnalysis _$RiskEncounterAnalysisFromJson(
    Map<String, dynamic> json) {
  return RiskEncounterAnalysis(
    id: json['id'] as int,
    date: json['date'] as int,
    riskFound: json['riskFound'] as int,
    deleted: json['deleted'] as int,
  );
}

Map<String, dynamic> _$RiskEncounterAnalysisToJson(
        RiskEncounterAnalysis instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'riskFound': instance.riskFound,
      'deleted': instance.deleted,
    };
