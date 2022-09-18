import 'package:json_annotation/json_annotation.dart';
part 'user_transaction_model.g.dart';

@JsonSerializable()
class UserTransaction {
  final String? status;
  final String? createdAt;
  final String? id;
  final int? amount;
  final String? name;
  final String? type;
  final String? sid;
  final String? cid;
  final String? vid;
  final int? v;

  UserTransaction(
      {this.status,
      this.createdAt,
      this.id,
      this.amount,
      this.name,
      this.type,
      this.sid,
      this.cid,
      this.vid,
      this.v});

  factory UserTransaction.fromJson(Map<String, dynamic> json) =>
      _$UserTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$UserTransactionToJson(this);
}
