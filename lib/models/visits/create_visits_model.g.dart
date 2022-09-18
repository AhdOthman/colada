// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_visits_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateVisits _$CreateVisitsFromJson(Map<String, dynamic> json) => CreateVisits(
      visit: json['visit'] == null
          ? null
          : CurrentVisits.fromJson(json['visit'] as Map<String, dynamic>),
      store: json['store'] == null
          ? null
          : StoreModel.fromJson(json['store'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateVisitsToJson(CreateVisits instance) =>
    <String, dynamic>{
      'visit': instance.visit,
      'store': instance.store,
    };
