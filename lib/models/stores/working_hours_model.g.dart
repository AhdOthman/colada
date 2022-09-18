// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'working_hours_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkingHoursModel _$WorkingHoursModelFromJson(Map<String, dynamic> json) =>
    WorkingHoursModel(
      weekday: json['weekday'] as String?,
      openingTime: json['openingTime'] as String?,
      closingTime: json['closingTime'] as String?,
    );

Map<String, dynamic> _$WorkingHoursModelToJson(WorkingHoursModel instance) =>
    <String, dynamic>{
      'weekday': instance.weekday,
      'openingTime': instance.openingTime,
      'closingTime': instance.closingTime,
    };
