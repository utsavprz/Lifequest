import 'package:json_annotation/json_annotation.dart';

part 'hospital.g.dart';

@JsonSerializable()
class Hospital {
  String? name;
  String? displayName;
  String? suburb;
  String? road;
  String? neighbourhood;
  double? lat;
  double? lon;

  Hospital(
      {this.name,
      this.lat,
      this.lon,
      this.displayName,
      this.road,
      this.neighbourhood,
      this.suburb});

  factory Hospital.fromJson(Map<String, dynamic> json) =>
      _$HospitalFromJson(json);

  Map<String, dynamic> toJson() => _$HospitalToJson(this);
}
