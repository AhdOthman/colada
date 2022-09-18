// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      wallet: json['wallet'] == null
          ? null
          : UserWalletModel.fromJson(json['wallet'] as Map<String, dynamic>),
      location: json['location'] == null
          ? null
          : UserLocationModel.fromJson(
              json['location'] as Map<String, dynamic>),
      favorites: (json['favorites'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      profileUrl: json['profileUrl'] as String?,
      dob: json['dob'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'dob': instance.dob,
      'gender': instance.gender,
      'profileUrl': instance.profileUrl,
      'wallet': instance.wallet,
      'location': instance.location,
      'favorites': instance.favorites,
    };
