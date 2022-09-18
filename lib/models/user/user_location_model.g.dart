// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLocationModel _$UserLocationModelFromJson(Map<String, dynamic> json) =>
    UserLocationModel(
      lat: json['lat'] as String?,
      lng: json['lng'] as String?,
      city: json['city'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$UserLocationModelToJson(UserLocationModel instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'city': instance.city,
      'address': instance.address,
    };
