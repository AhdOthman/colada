import 'package:coladaapp/models/offers/timing_model.dart';
import 'package:coladaapp/models/stores/details_model.dart';
import 'offers_period_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'offers_model.g.dart';

@JsonSerializable()
class OffersModel {
  final String? status;
  final String? id;
  final bool? isDeleted;
  final String? sid;
  final String? name;
  final String? photo;
  final int? amount;
  final String? type;
  final DetailsModel? details;
  final List<TimingModel>? timings;
  final OfferPeriodModel? offerPeriodModel;

  OffersModel(
      {this.status,
      this.id,
      this.isDeleted,
      this.sid,
      this.name,
      this.amount,
      this.photo,
      this.details,
      this.offerPeriodModel,
      this.timings,
      this.type});

  factory OffersModel.fromJson(Map<String, dynamic> json) =>
      _$OffersModelFromJson(json);

  Map<String, dynamic> toJson() => _$OffersModelToJson(this);
}
