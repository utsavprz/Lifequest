// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_request_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignRequestResponse _$CampaignRequestResponseFromJson(
        Map<String, dynamic> json) =>
    CampaignRequestResponse(
      json['success'] as bool?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => Campaign.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CampaignRequestResponseToJson(
        CampaignRequestResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
