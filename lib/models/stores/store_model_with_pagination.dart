import 'package:coladaapp/models/pagination_model.dart';
import 'package:coladaapp/models/stores/store_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'store_model_with_pagination.g.dart';

@JsonSerializable()
class StoreModelWithPagination {
  List<StoreModel>? stores = [];
  Pagination? pagination;

  StoreModelWithPagination({this.stores, this.pagination});

  factory StoreModelWithPagination.fromJson(Map<String, dynamic> json) =>
      _$StoreModelWithPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$StoreModelWithPaginationToJson(this);
}
