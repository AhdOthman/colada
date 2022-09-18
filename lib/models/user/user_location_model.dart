import 'package:json_annotation/json_annotation.dart';
part 'user_location_model.g.dart';

@JsonSerializable()
class UserLocationModel {
  String? lat;
  String? lng;
  String? city;
  String? address;

  UserLocationModel({this.lat, this.lng, this.city, this.address});

  factory UserLocationModel.fromJson(Map<String, dynamic> json) =>
      _$UserLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserLocationModelToJson(this);
}
