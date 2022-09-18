// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_visits_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentVisits _$CurrentVisitsFromJson(Map<String, dynamic> json) =>
    CurrentVisits(
      id: json['_id'] as String?,
      visitTime: json['visitTime'] as String?,
      status: json['status'] as String?,
      checkout: json['checkout'] as String?,
      oid: json['oid'] as String?,
      sid: json['sid'] as String?,
      cid: json['cid'] as String?,
      v: json['v'] as int?,
    );

Map<String, dynamic> _$CurrentVisitsToJson(CurrentVisits instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'visitTime': instance.visitTime,
      'status': instance.status,
      'checkout': instance.checkout,
      'oid': instance.oid,
      'sid': instance.sid,
      'cid': instance.cid,
      'v': instance.v,
    };
