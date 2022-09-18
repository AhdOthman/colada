import 'package:json_annotation/json_annotation.dart';
part 'current_visits_model.g.dart';

@JsonSerializable()
class CurrentVisits {
  final String? id;
  final String? visitTime;
  final String? status;
  final String? checkout;
  final String? oid;
  final String? sid;
  final String? cid;
  final int? v;

  CurrentVisits(
      {this.id,
      this.visitTime,
      this.status,
      this.checkout,
      this.oid,
      this.sid,
      this.cid,
      this.v});

  factory CurrentVisits.fromJson(Map<String, dynamic> data) =>
      _$CurrentVisitsFromJson(data);

  Map<String, dynamic> toJson() => _$CurrentVisitsToJson(this);
}
