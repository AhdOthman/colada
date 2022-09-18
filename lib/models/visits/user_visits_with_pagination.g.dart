// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_visits_with_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVisitsWithPagination _$UserVisitsWithPaginationFromJson(
        Map<String, dynamic> json) =>
    UserVisitsWithPagination(
      visits: (json['visits'] as List<dynamic>?)
          ?.map((e) => UserVisits.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserVisitsWithPaginationToJson(
        UserVisitsWithPagination instance) =>
    <String, dynamic>{
      'visits': instance.visits,
      'pagination': instance.pagination,
    };
