import 'package:json_annotation/json_annotation.dart';
part 'check_out_details.g.dart';

@JsonSerializable()
class CheckOutDetails {
  String? cashid;
  int? orderAmount;
  int? discountAmount;
  int? cashbackUsed;
  int? grandTotalAmount;

  CheckOutDetails(
      {this.cashid,
      this.orderAmount,
      this.discountAmount,
      this.cashbackUsed,
      this.grandTotalAmount});

  factory CheckOutDetails.fromJson(Map<String, dynamic> data) =>
      _$CheckOutDetailsFromJson(data);

  Map<String, dynamic> toJson() => _$CheckOutDetailsToJson(this);
}
