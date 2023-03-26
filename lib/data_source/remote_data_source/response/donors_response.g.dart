// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donors_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DonorsResponse _$DonorsResponseFromJson(Map<String, dynamic> json) =>
    DonorsResponse(
      json['success'] as bool?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DonorsResponseToJson(DonorsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
