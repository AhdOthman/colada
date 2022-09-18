import 'package:coladaapp/utils/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static const double buttonRadius = 8;
  static final TextTheme lightTextTheme = TextTheme(
    caption: _textStyle,
    subtitle1: _subTextStyle1,
    subtitle2: _subTextStyle2,
    headline1: _headTextStyle1,
    headline2: _headTextStyle2,
    headline3: _headTextStyle3,
    bodyText1: _textStyle,
    bodyText2: _textStyle,
    button: _textStyle,
    headline4: _textStyle,
    headline5: _textStyle,
    headline6: _textStyle,
    overline: _textStyle,
  );

  static const TextStyle _textStyle = TextStyle(
    fontSize: 16,
    color: AppColors.black,
  );

  static final TextStyle _subTextStyle1 =
      _textStyle.copyWith(fontSize: 14, color: AppColors.black);
  static final TextStyle _subTextStyle2 =
      _textStyle.copyWith(fontSize: 12, color: AppColors.black);

  static final TextStyle _headTextStyle1 =
      _textStyle.copyWith(fontSize: 24, color: AppColors.black);
  static final TextStyle _headTextStyle2 =
      _textStyle.copyWith(fontSize: 22, color: AppColors.black);
  static final TextStyle _headTextStyle3 =
      _textStyle.copyWith(fontSize: 20, color: AppColors.black);

  static final ThemeData lightAppTheme = ThemeData(
    appBarTheme: const AppBarTheme(
        actionsIconTheme: IconThemeData(
      color: AppColors.primaryColor,
      size: 20,
    )),
    fontFamily: 'sans-serif-condensed',
    primaryColor: AppColors.primaryColor,
    primaryColorDark: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.white80,
    textTheme: lightTextTheme,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.black,
    ),
    cupertinoOverrideTheme: const CupertinoThemeData(
      primaryColor: AppColors.black,
    ),
    cardTheme: CardTheme(
      color: AppColors.white,
      elevation: 1,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    errorColor: AppColors.red,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
          backgroundColor: MaterialStateProperty.all(
            AppColors.primaryColor,
          ),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          textStyle: MaterialStateProperty.all(_textStyle),
          foregroundColor: MaterialStateProperty.all(AppColors.black),
          padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: lightTextTheme.caption,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: Constants.padding / 2),
      focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.black)),
      enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.black)),
    ),
    primaryIconTheme: const IconThemeData(color: AppColors.black, size: 20),
    iconTheme: const IconThemeData(
      color: AppColors.black,
      size: 20,
    ),
    colorScheme: ThemeData()
        .colorScheme
        .copyWith(
          secondary: AppColors.primaryColor,
        )
        .copyWith(secondary: AppColors.black),
  );
}
