import 'package:coladaapp/models/visits/sid_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_visits_model.g.dart';

@JsonSerializable()
class UserVisits {
  final String? visitTime;
  final String? status;
  final String? id;
  final String? oid;
  final Sid? sid;
  final String? cid;
  final String? code;
  final String? v;

  UserVisits(
      {this.visitTime,
      this.status,
      this.id,
      this.oid,
      this.sid,
      this.cid,
      this.code,
      this.v});
  factory UserVisits.fromJson(Map<String, dynamic> data) =>
      _$UserVisitsFromJson(data);

  Map<String, dynamic> toJson() => _$UserVisitsToJson(this);
}
