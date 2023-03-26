import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'user_profile.g.dart';

@JsonSerializable()
@Entity()
class UserProfile {

  @Id(assignable: true)
  int? profileId;

  @Unique()
  @Index()
  @JsonKey(name: '_id')
  String? id;
  
  String? user;
  String? firstName;
  String? lastName;
  int? age;
  String? gender;
  String? bloodType;
  String? phoneNumber;
  double? lat;
  double? lon;
  String? streetName;
  String? city;
  String? image;
  bool? canDonate;
  List<String>? donationRecords;
  List<String>? requestRecords;

  UserProfile(
      {this.id,
      this.firstName,
      this.lastName,
      this.age,
      this.gender,
      this.bloodType,
      this.phoneNumber,
      this.lat,
      this.lon,
      this.streetName,
      this.city,
      this.image,
      this.canDonate,
      this.donationRecords,
      this.requestRecords,
      this.profileId = 0});

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
