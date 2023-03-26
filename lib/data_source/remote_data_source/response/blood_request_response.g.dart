// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_request_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BloodRequestResponse _$BloodRequestResponseFromJson(
        Map<String, dynamic> json) =>
    BloodRequestResponse(
      json['success'] as bool?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => UserBloodRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BloodRequestResponseToJson(
        BloodRequestResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
