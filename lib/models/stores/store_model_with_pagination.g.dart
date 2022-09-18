// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_model_with_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreModelWithPagination _$StoreModelWithPaginationFromJson(
        Map<String, dynamic> json) =>
    StoreModelWithPagination(
      stores: (json['stores'] as List<dynamic>?)
          ?.map((e) => StoreModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StoreModelWithPaginationToJson(
        StoreModelWithPagination instance) =>
    <String, dynamic>{
      'stores': instance.stores,
      'pagination': instance.pagination,
    };
