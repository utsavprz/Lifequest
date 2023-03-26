import 'package:json_annotation/json_annotation.dart';
import 'package:lifequest/models/campaign.dart';

part 'campaign_request_response.g.dart';

@JsonSerializable()
class CampaignRequestResponse {
  bool? success;
  String? message;
  List<Campaign>? data;

  CampaignRequestResponse(this.success, this.message, this.data);

  factory CampaignRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$CampaignRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignRequestResponseToJson(this);
}
