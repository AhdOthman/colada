import 'package:json_annotation/json_annotation.dart';
part 'working_hours_model.g.dart';

@JsonSerializable()
class WorkingHoursModel {
  String? weekday;
  String? openingTime;
  String? closingTime;

  WorkingHoursModel({this.weekday, this.openingTime, this.closingTime});

  factory WorkingHoursModel.fromJson(Map<String, dynamic> json) =>
      _$WorkingHoursModelFromJson(json);

  Map<String, dynamic> toJson() => _$WorkingHoursModelToJson(this);
}
