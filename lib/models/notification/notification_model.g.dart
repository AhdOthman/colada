// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      offer: (json['offer'] as List<dynamic>?)
          ?.map((e) => OffersModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      data: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => NotificationDateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'offer': instance.offer,
      'data': instance.data,
    };
