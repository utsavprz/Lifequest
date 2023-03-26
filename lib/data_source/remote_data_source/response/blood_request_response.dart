import 'package:json_annotation/json_annotation.dart';
import 'package:lifequest/models/user_blood_request.dart';

part 'blood_request_response.g.dart';

@JsonSerializable()
class BloodRequestResponse {
  bool? success;
  String? message;
  List<UserBloodRequest>? data;

  BloodRequestResponse(this.success, this.message, this.data);

  factory BloodRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$BloodRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BloodRequestResponseToJson(this);
}
