import 'package:json_annotation/json_annotation.dart';
part 'pagination_model.g.dart';

@JsonSerializable()
class Pagination {
  bool? hasPrevPage;
  bool? hasNextPage;
  int? prevPage;
  int? nextPage;
  int? perPage;
  int? totalPages;
  int? page;

  Pagination(
      {this.hasPrevPage,
      this.hasNextPage,
      this.prevPage,
      this.nextPage,
      this.perPage,
      this.totalPages,
      this.page});

  factory Pagination.fromJson(Map<String, dynamic> data) =>
      _$PaginationFromJson(data);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
