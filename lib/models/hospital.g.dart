// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hospital _$HospitalFromJson(Map<String, dynamic> json) => Hospital(
      name: json['name'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      displayName: json['displayName'] as String?,
      road: json['road'] as String?,
      neighbourhood: json['neighbourhood'] as String?,
      suburb: json['suburb'] as String?,
    );

Map<String, dynamic> _$HospitalToJson(Hospital instance) => <String, dynamic>{
      'name': instance.name,
      'displayName': instance.displayName,
      'suburb': instance.suburb,
      'road': instance.road,
      'neighbourhood': instance.neighbourhood,
      'lat': instance.lat,
      'lon': instance.lon,
    };
