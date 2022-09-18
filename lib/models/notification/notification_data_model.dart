import 'package:json_annotation/json_annotation.dart';
part 'notification_data_model.g.dart';

@JsonSerializable()
class NotificationDateModel {
  final List<String>? customers;
  final String? createdAt;
  final String? id;
  final String? title;
  final String? description;
  final String? offerID;
  final String? scheduledAt;
  final String? v;

  NotificationDateModel(
      {this.customers,
      this.createdAt,
      this.id,
      this.title,
      this.description,
      this.offerID,
      this.scheduledAt,
      this.v});

  factory NotificationDateModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationDateModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDateModelToJson(this);
}
