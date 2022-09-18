import 'package:coladaapp/models/user/user_location_model.dart';
import 'package:coladaapp/models/user/user_wallet_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? id;
  String? name;
  String? phoneNumber;
  String? email;
  String? dob;
  String? gender;
  String? profileUrl;
  UserWalletModel? wallet;
  UserLocationModel? location;
  List<String>? favorites;

  UserModel(
      {this.id,
      this.name,
      this.phoneNumber,
      this.email,
      this.wallet,
      this.location,
      this.favorites,
      this.profileUrl,
      this.dob,
      this.gender});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
