import 'package:coladaapp/models/pagination_model.dart';
import 'package:coladaapp/models/visits/user_visits_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'user_visits_with_pagination.g.dart';

@JsonSerializable()
class UserVisitsWithPagination {
  List<UserVisits>? visits = [];
  Pagination? pagination;

  UserVisitsWithPagination({this.visits, this.pagination});

  factory UserVisitsWithPagination.fromJson(Map<String, dynamic> json) =>
      _$UserVisitsWithPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$UserVisitsWithPaginationToJson(this);
}
