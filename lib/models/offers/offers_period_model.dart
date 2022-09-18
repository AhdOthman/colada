import 'package:json_annotation/json_annotation.dart';
part 'offers_period_model.g.dart';

@JsonSerializable()
class OfferPeriodModel {
  String? startingDate;
  String? endingDate;
  OfferPeriodModel({
    this.startingDate,
    this.endingDate,
  });

  factory OfferPeriodModel.fromJson(Map<String, dynamic> json) =>
      _$OfferPeriodModelFromJson(json);

  Map<String, dynamic> toJson() => _$OfferPeriodModelToJson(this);
}
