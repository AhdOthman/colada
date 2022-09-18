import 'package:json_annotation/json_annotation.dart';
part 'store_location_model.g.dart';

@JsonSerializable()
class StoreLocationModel {
  double? lat;
  double? lng;

  StoreLocationModel({this.lat, this.lng});

  factory StoreLocationModel.fromJson(Map<String, dynamic> json) =>
      _$StoreLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreLocationModelToJson(this);
}
