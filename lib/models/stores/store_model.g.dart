// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreModel _$StoreModelFromJson(Map<String, dynamic> json) => StoreModel(
      distance: json['distance'] as num?,
      location: json['location'] == null
          ? null
          : StoreLocationModel.fromJson(
              json['location'] as Map<String, dynamic>),
      details: json['details'] == null
          ? null
          : DetailsModel.fromJson(json['details'] as Map<String, dynamic>),
      name: json['name'] as String?,
      id: json['_id'] as String?,
      coladaRate: json['coladaRate'] as num?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isFeatured: json['isFeatured'] as bool?,
      rank: json['rank'] as int?,
      rating: json['rating'] as int?,
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      workingHours: (json['workingHours'] as List<dynamic>?)
          ?.map((e) => WorkingHoursModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      menu: json['menu'] as String?,
      cuisines: (json['cuisines'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      wallet: json['wallet'] == null
          ? null
          : UserWalletModel.fromJson(json['wallet'] as Map<String, dynamic>),
    )..isSeclected = json['isSeclected'] ?? false;

Map<String, dynamic> _$StoreModelToJson(StoreModel instance) =>
    <String, dynamic>{
      'distance': instance.distance,
      'location': instance.location,
      'details': instance.details,
      'name': instance.name,
      '_id': instance.id,
      'coladaRate': instance.coladaRate,
      'categories': instance.categories,
      'isFeatured': instance.isFeatured,
      'rank': instance.rank,
      'rating': instance.rating,
      'photos': instance.photos,
      'workingHours': instance.workingHours,
      'menu': instance.menu,
      'isSeclected': instance.isSeclected,
      'cuisines': instance.cuisines,
      'wallet': instance.wallet,
    };
