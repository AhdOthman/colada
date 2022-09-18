import 'package:json_annotation/json_annotation.dart';

part 'offer_details_model.g.dart';

@JsonSerializable()
class DetailsModel {
  String? en;
  String? ar;

  DetailsModel({this.en, this.ar});

  factory DetailsModel.fromJson(Map<String, dynamic> json) =>
      _$DetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DetailsModelToJson(this);
}
