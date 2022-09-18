import 'package:json_annotation/json_annotation.dart';
part 'timing_model.g.dart';

@JsonSerializable()
class TimingModel {
  String? weekDay;
  String? startingTime;
  String? endingTime;
  String? date;

  TimingModel({this.weekDay, this.startingTime, this.endingTime, this.date});

  factory TimingModel.fromJson(Map<String, dynamic> json) =>
      _$TimingModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimingModelToJson(this);
}
