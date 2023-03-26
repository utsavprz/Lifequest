// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Campaign _$CampaignFromJson(Map<String, dynamic> json) => Campaign(
      name: json['name'] as String?,
      location: json['location'] as Map<String, dynamic>?,
      datetimeOrganized: json['datetimeOrganized'] == null
          ? null
          : DateTime.parse(json['datetimeOrganized'] as String),
      status: json['status'] as String?,
      campaignId: json['campaignId'] as int? ?? 0,
    )
      ..id = json['_id'] as String?
      ..streetName = json['streetName'] as String?
      ..city = json['city'] as String?;

Map<String, dynamic> _$CampaignToJson(Campaign instance) => <String, dynamic>{
      'campaignId': instance.campaignId,
      '_id': instance.id,
      'name': instance.name,
      'streetName': instance.streetName,
      'city': instance.city,
      'location': instance.location,
      'datetimeOrganized': instance.datetimeOrganized?.toIso8601String(),
      'status': instance.status,
    };
