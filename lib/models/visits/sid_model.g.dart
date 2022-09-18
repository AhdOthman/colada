// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sid_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sid _$SidFromJson(Map<String, dynamic> json) => Sid(
      (json['cuisines'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['rating'] as int?,
      json['_id'] as String?,
      json['name'] as String?,
    );

Map<String, dynamic> _$SidToJson(Sid instance) => <String, dynamic>{
      'cuisines': instance.cuisines,
      'photos': instance.photos,
      'rating': instance.rating,
      '_id': instance.id,
      'name': instance.name,
    };
