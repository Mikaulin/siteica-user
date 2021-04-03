import 'package:json_annotation/json_annotation.dart';

part 'encounter.g.dart';

@JsonSerializable()
class Encounter {
  final int id;
  final String ownSeed;
  final String encounterSeed;
  final double latitude;
  final double longitude;
  final int startDate;
  final int endDate;
  final int averageDistance;
  final int transmitted;

  Encounter({
    this.id,
    this.ownSeed,
    this.encounterSeed,
    this.latitude,
    this.longitude,
    this.startDate,
    this.endDate,
    this.averageDistance,
    this.transmitted,
  });

  factory Encounter.fromJson(Map<String, dynamic> json) =>
      _$EncounterFromJson(json);

  Map<String, dynamic> toJson() => _$EncounterToJson(this);
}
