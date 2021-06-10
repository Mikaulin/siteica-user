import 'package:json_annotation/json_annotation.dart';

part 'encounter_seed.g.dart';

@JsonSerializable()
class EncounterSeed {
  final int id;
  final int userId;
  final String seedUuid;
  final int date;
  final int deleted;

  EncounterSeed({
    this.id,
    this.userId,
    this.seedUuid,
    this.date,
    this.deleted,
  });

  factory EncounterSeed.fromJson(Map<String, dynamic> json) =>
      _$EncounterSeedFromJson(json);

  Map<String, dynamic> toJson() => _$EncounterSeedToJson(this);
}
