import 'package:coladaapp/models/notification/notification_data_model.dart';
import 'package:coladaapp/models/offers/offers_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  final List<OffersModel>? offer;
  final List<NotificationDateModel>? data;

  NotificationModel({this.offer, this.data});

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
