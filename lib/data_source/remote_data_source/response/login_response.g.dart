// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      json['success'] as bool?,
      json['message'] as String?,
      json['token'] as String?,
      json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'token': instance.token,
      'data': instance.data,
    };
