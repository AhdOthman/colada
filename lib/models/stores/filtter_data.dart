// ignore_for_file: implementation_imports

import 'package:coladaapp/generated/locale_keys.g.dart';
import 'package:easy_localization/src/public_ext.dart';

class FiltterDate {
  final String title;
  final String value;
  final String? svgPath;
  final String? startTime;
  final String? endTime;
  bool isSelected;

  FiltterDate(
      {required this.title,
      required this.value,
      required this.svgPath,
      required this.isSelected,
      this.startTime,
      this.endTime});
}

List<FiltterDate> categoriesData = [
  FiltterDate(
      title: LocaleKeys.all_title.tr(),
      value: "All",
      svgPath: null,
      isSelected: true),
  FiltterDate(
      title: LocaleKeys.snack_title.tr(),
      value: "Snack",
      svgPath: 'assets/svg/nachos.svg',
      isSelected: false),
  FiltterDate(
      title: LocaleKeys.brunch_title.tr(),
      value: "Brunch",
      svgPath: 'assets/svg/sandwich.svg',
      isSelected: false),
  FiltterDate(
      title: LocaleKeys.launch_title.tr(),
      value: "Launch",
      svgPath: 'assets/svg/launch.svg',
      isSelected: false),
  FiltterDate(
      title: LocaleKeys.breakfast_title.tr(),
      value: "Breakfast",
      svgPath: 'assets/svg/coffee.svg',
      isSelected: false),
];

List<FiltterDate> timingData = [
  FiltterDate(
      title: LocaleKeys.morning_filter_option.tr(),
      value: "Morning",
      svgPath: null,
      endTime: "8",
      startTime: "12",
      isSelected: true),
  FiltterDate(
      title: LocaleKeys.afternoon_filter_option.tr(),
      value: "Afternoon",
      svgPath: 'assets/svg/nachos.svg',
      endTime: "16",
      startTime: "12",
      isSelected: false),
  FiltterDate(
      title: LocaleKeys.evening_filter_option.tr(),
      value: "Evening",
      endTime: "20",
      startTime: "16",
      svgPath: 'assets/svg/sandwich.svg',
      isSelected: false),
  FiltterDate(
      title: 'night',
      value: "Night",
      endTime: "24",
      startTime: "20",
      svgPath: 'assets/svg/sandwich.svg',
      isSelected: false),
  FiltterDate(
      title: 'late night',
      value: "Late Night",
      endTime: "4",
      startTime: "24",
      svgPath: 'assets/svg/sandwich.svg',
      isSelected: false),
];

List<FiltterDate> cuisinesData = [
  FiltterDate(
      title: LocaleKeys.all_title.tr(),
      value: "All",
      svgPath: null,
      isSelected: true),
  FiltterDate(
      title: LocaleKeys.italian_filter_types.tr(),
      value: "Italian",
      svgPath: 'assets/svg/nachos.svg',
      isSelected: false),
  FiltterDate(
      title: LocaleKeys.american_filter_types.tr(),
      value: "American",
      svgPath: 'assets/svg/sandwich.svg',
      isSelected: false),
  FiltterDate(
      title: LocaleKeys.street_food_filter_types.tr(),
      value: "Street Food",
      svgPath: 'assets/svg/launch.svg',
      isSelected: false),
  FiltterDate(
      title: LocaleKeys.vegan_filter_types.tr(),
      value: "Vegan",
      svgPath: 'assets/svg/coffee.svg',
      isSelected: false),
];
