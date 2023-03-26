import 'package:json_annotation/json_annotation.dart';
import 'package:lifequest/models/user.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  bool? success;
  String? message;
  User? data;

  UserResponse(this.success, this.message);

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
