import 'package:coladaapp/models/stores/store_model.dart';
import 'package:coladaapp/models/visits/current_visits_model.dart';

import 'package:json_annotation/json_annotation.dart';
part 'create_visits_model.g.dart';

@JsonSerializable()
class CreateVisits {
  final CurrentVisits? visit;
  final StoreModel? store;

  CreateVisits({this.visit, this.store});

  factory CreateVisits.fromJson(Map<String, dynamic> data) =>
      _$CreateVisitsFromJson(data);

  Map<String, dynamic> toJson() => _$CreateVisitsToJson(this);
}
