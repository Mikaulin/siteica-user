import 'package:json_annotation/json_annotation.dart';

part 'encounter.g.dart';

@JsonSerializable()
class Encounter {
  final int id;
  final int ownSeedId;
  final String encounterSeedUuid;
  final double latitude;
  final double longitude;
  final int date;
  final double distance;
  final int transmitted;

  Encounter({
    this.id,
    this.ownSeedId,
    this.encounterSeedUuid,
    this.latitude,
    this.longitude,
    this.date,
    this.distance,
    this.transmitted,
  });

  factory Encounter.fromJson(Map<String, dynamic> json) =>
      _$EncounterFromJson(json);

  Map<String, dynamic> toJson() => _$EncounterToJson(this);
}
