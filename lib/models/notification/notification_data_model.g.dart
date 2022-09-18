// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationDateModel _$NotificationDateModelFromJson(
        Map<String, dynamic> json) =>
    NotificationDateModel(
      customers: (json['customers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json['createdAt'] as String?,
      id: json['_id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      offerID: json['offerID'] as String?,
      scheduledAt: json['scheduledAt'] as String?,
      v: json['v'] as String?,
    );

Map<String, dynamic> _$NotificationDateModelToJson(
        NotificationDateModel instance) =>
    <String, dynamic>{
      'customers': instance.customers,
      'createdAt': instance.createdAt,
      '_id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'offerID': instance.offerID,
      'scheduledAt': instance.scheduledAt,
      'v': instance.v,
    };
