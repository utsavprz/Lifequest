import 'package:json_annotation/json_annotation.dart';
import 'package:lifequest/models/user.dart';
import 'package:lifequest/models/user_blood_request.dart';

part 'donors_response.g.dart';

@JsonSerializable()
class DonorsResponse {
  bool? success;
  String? message;
  List<User>? data;

  DonorsResponse(this.success, this.message, this.data);

  factory DonorsResponse.fromJson(Map<String, dynamic> json) =>
      _$DonorsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DonorsResponseToJson(this);
}
