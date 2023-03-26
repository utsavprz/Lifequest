// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      role: json['role'] as String?,
      profile: json['profile'] == null
          ? null
          : UserProfile.fromJson(json['profile'] as Map<String, dynamic>),
      points: json['points'] as int? ?? 0,
      userId: json['userId'] as int? ?? 0,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      '_id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'role': instance.role,
      'points': instance.points,
      'profile': instance.profile,
    };
