// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_visits_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVisits _$UserVisitsFromJson(Map<String, dynamic> json) => UserVisits(
      visitTime: json['visitTime'] as String?,
      status: json['status'] as String?,
      id: json['_id'] as String?,
      oid: json['oid'] as String?,
      sid: json['sid'] == null
          ? null
          : Sid.fromJson(json['sid'] as Map<String, dynamic>),
      cid: json['cid'] as String?,
      code: json['code'] as String?,
      v: json['v'] as String?,
    );

Map<String, dynamic> _$UserVisitsToJson(UserVisits instance) =>
    <String, dynamic>{
      'visitTime': instance.visitTime,
      'status': instance.status,
      '_id': instance.id,
      'oid': instance.oid,
      'sid': instance.sid,
      'cid': instance.cid,
      'code': instance.code,
      'v': instance.v,
    };
