// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_wallet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWalletModel _$UserWalletModelFromJson(Map<String, dynamic> json) =>
    UserWalletModel(
      balance: json['balance'] as num?,
      lastUpdated: json['lastUpdated'] as String?,
      cashbackRate: (json['cashbackRate'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UserWalletModelToJson(UserWalletModel instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'lastUpdated': instance.lastUpdated,
      'cashbackRate': instance.cashbackRate,
    };
