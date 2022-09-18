import 'package:json_annotation/json_annotation.dart';
part 'sid_model.g.dart';

@JsonSerializable()
class Sid {
  final List<String>? cuisines;
  final List<String>? photos;
  final int? rating;
  final String? id;
  final String? name;

  Sid(this.cuisines, this.photos, this.rating, this.id, this.name);

  factory Sid.fromJson(Map<String, dynamic> data) => _$SidFromJson(data);

  Map<String, dynamic> toJson() => _$SidToJson(this);
}
