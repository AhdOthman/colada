import 'package:coladaapp/models/stores/details_model.dart';
import 'package:coladaapp/models/stores/working_hours_model.dart';
import 'package:coladaapp/models/user/user_wallet_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'store_location_model.dart';
part 'store_model.g.dart';

@JsonSerializable()
class StoreModel {
  num? distance;
  StoreLocationModel? location;
  DetailsModel? details;
  String? name;
  String? id;
  num? coladaRate;
  List<String>? categories;
  bool? isFeatured;
  int? rank;
  int? rating;
  List<String>? photos;
  List<WorkingHoursModel>? workingHours;
  String? menu;
  bool isSeclected = false;
  List<String>? cuisines;
  UserWalletModel? wallet;

  StoreModel(
      {this.distance,
      this.location,
      this.details,
      this.name,
      this.id,
      this.coladaRate,
      this.categories,
      this.isFeatured,
      this.rank,
      this.rating,
      this.photos,
      this.workingHours,
      this.menu,
      this.isSeclected = false,
      this.cuisines,
      this.wallet});

  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreModelToJson(this);
}
