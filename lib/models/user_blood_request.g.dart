// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_blood_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBloodRequest _$UserBloodRequestFromJson(Map<String, dynamic> json) =>
    UserBloodRequest(
      id: json['_id'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      bloodType: json['bloodType'] as String?,
      quantity: json['quantity'] as int?,
      hospital: json['hospital'] == null
          ? null
          : Hospital.fromJson(json['hospital'] as Map<String, dynamic>),
      location: json['location'] as Map<String, dynamic>?,
      urgency: json['urgency'] as String?,
      datetimeRequested: json['datetimeRequested'] as String?,
      donor: json['donor'] == null
          ? null
          : User.fromJson(json['donor'] as Map<String, dynamic>),
      datetimeDonated: json['datetimeDonated'] as String?,
      status: json['status'] as String?,
      requestId: json['requestId'] as int? ?? 0,
    );

Map<String, dynamic> _$UserBloodRequestToJson(UserBloodRequest instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      '_id': instance.id,
      'user': instance.user,
      'bloodType': instance.bloodType,
      'quantity': instance.quantity,
      'hospital': instance.hospital,
      'location': instance.location,
      'urgency': instance.urgency,
      'datetimeRequested': instance.datetimeRequested,
      'donor': instance.donor,
      'datetimeDonated': instance.datetimeDonated,
      'status': instance.status,
    };
