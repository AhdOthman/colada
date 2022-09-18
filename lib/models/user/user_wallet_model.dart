import 'package:json_annotation/json_annotation.dart';
part 'user_wallet_model.g.dart';

@JsonSerializable()
class UserWalletModel {
  num? balance;
  String? lastUpdated;
  double? cashbackRate;

  UserWalletModel({this.balance, this.lastUpdated, this.cashbackRate});

  factory UserWalletModel.fromJson(Map<String, dynamic> json) =>
      _$UserWalletModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserWalletModelToJson(this);
}
