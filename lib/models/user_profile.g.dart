// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      id: json['_id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      age: json['age'] as int?,
      gender: json['gender'] as String?,
      bloodType: json['bloodType'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      streetName: json['streetName'] as String?,
      city: json['city'] as String?,
      image: json['image'] as String?,
      canDonate: json['canDonate'] as bool?,
      donationRecords: (json['donationRecords'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      requestRecords: (json['requestRecords'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      profileId: json['profileId'] as int? ?? 0,
    )..user = json['user'] as String?;

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'profileId': instance.profileId,
      '_id': instance.id,
      'user': instance.user,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'age': instance.age,
      'gender': instance.gender,
      'bloodType': instance.bloodType,
      'phoneNumber': instance.phoneNumber,
      'lat': instance.lat,
      'lon': instance.lon,
      'streetName': instance.streetName,
      'city': instance.city,
      'image': instance.image,
      'canDonate': instance.canDonate,
      'donationRecords': instance.donationRecords,
      'requestRecords': instance.requestRecords,
    };
