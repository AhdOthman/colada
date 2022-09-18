// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimingModel _$TimingModelFromJson(Map<String, dynamic> json) => TimingModel(
      weekDay: json['weekDay'] as String?,
      startingTime: json['startingTime'] as String?,
      endingTime: json['endingTime'] as String?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$TimingModelToJson(TimingModel instance) =>
    <String, dynamic>{
      'weekDay': instance.weekDay,
      'startingTime': instance.startingTime,
      'endingTime': instance.endingTime,
      'date': instance.date,
    };
