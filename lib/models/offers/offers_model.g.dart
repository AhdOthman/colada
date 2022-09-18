// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OffersModel _$OffersModelFromJson(Map<String, dynamic> json) => OffersModel(
      status: json['status'] as String?,
      id: json['_id'] as String?,
      isDeleted: json['isDeleted'] as bool?,
      sid: json['sid'] as String?,
      name: json['name'] as String?,
      amount: json['amount'],
      photo: json['photo'] as String?,
      details: json['details'] == null
          ? null
          : DetailsModel.fromJson(json['details'] as Map<String, dynamic>),
      offerPeriodModel: json['offerPeriodModel'] == null
          ? null
          : OfferPeriodModel.fromJson(
              json['offerPeriodModel'] as Map<String, dynamic>),
      timings: (json['timings'] as List<dynamic>?)
          ?.map((e) => TimingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as String?,
    );

Map<String, dynamic> _$OffersModelToJson(OffersModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      '_id': instance.id,
      'isDeleted': instance.isDeleted,
      'sid': instance.sid,
      'name': instance.name,
      'photo': instance.photo,
      'amount': instance.amount,
      'type': instance.type,
      'details': instance.details,
      'timings': instance.timings,
      'offerPeriodModel': instance.offerPeriodModel,
    };
