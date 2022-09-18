// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTransaction _$UserTransactionFromJson(Map<String, dynamic> json) =>
    UserTransaction(
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      id: json['_id'] as String?,
      amount: json['amount'] as int?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      sid: json['sid'] as String?,
      cid: json['cid'] as String?,
      vid: json['vid'] as String?,
      v: json['__v'] as int?,
    );

Map<String, dynamic> _$UserTransactionToJson(UserTransaction instance) =>
    <String, dynamic>{
      'status': instance.status,
      'createdAt': instance.createdAt,
      '_id': instance.id,
      'amount': instance.amount,
      'name': instance.name,
      'type': instance.type,
      'sid': instance.sid,
      'cid': instance.cid,
      'vid': instance.vid,
      '__v': instance.v,
    };
