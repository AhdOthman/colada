// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      hasPrevPage: json['hasPrevPage'] as bool?,
      hasNextPage: json['hasNextPage'] as bool?,
      prevPage: json['prevPage'] as int?,
      nextPage: json['nextPage'] as int?,
      perPage: json['perPage'] as int?,
      totalPages: json['totalPages'] as int?,
      page: json['page'] as int?,
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'hasPrevPage': instance.hasPrevPage,
      'hasNextPage': instance.hasNextPage,
      'prevPage': instance.prevPage,
      'nextPage': instance.nextPage,
      'perPage': instance.perPage,
      'totalPages': instance.totalPages,
      'page': instance.page,
    };
