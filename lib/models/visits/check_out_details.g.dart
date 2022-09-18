// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_out_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckOutDetails _$CheckOutDetailsFromJson(Map<String, dynamic> json) =>
    CheckOutDetails(
      cashid: json['cashid'] as String?,
      orderAmount: json['orderAmount'] as int?,
      discountAmount: json['discountAmount'] as int?,
      cashbackUsed: json['cashbackUsed'] as int?,
      grandTotalAmount: json['grandTotalAmount'] as int?,
    );

Map<String, dynamic> _$CheckOutDetailsToJson(CheckOutDetails instance) =>
    <String, dynamic>{
      'cashid': instance.cashid,
      'orderAmount': instance.orderAmount,
      'discountAmount': instance.discountAmount,
      'cashbackUsed': instance.cashbackUsed,
      'grandTotalAmount': instance.grandTotalAmount,
    };
