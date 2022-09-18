// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreLocationModel _$StoreLocationModelFromJson(Map<String, dynamic> json) =>
    StoreLocationModel(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$StoreLocationModelToJson(StoreLocationModel instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };
