import 'package:coladaapp/utils/constants/constants.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'text_widget.dart';

class ButtonIconWidget extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  final Color? textColor, borderColor, disabledColor;
  final Color backgroundColor;
  final double? shapeRadius;
  final double elevation;
  final double? fontSize;
  final double verticalTextPadding;
  final double horizontalTextPadding;
  final TextDirection? textDirection;
  final FontWeight? fontWeight;
  final Widget? widget;
  final Widget icon;

  const ButtonIconWidget(
      {Key? key,
      this.title,
      required this.onPressed,
      this.textColor,
      this.borderColor,
      this.backgroundColor = AppColors.primaryColor,
      this.elevation = 0,
      this.fontSize,
      this.verticalTextPadding = Constants.padding / 2,
      this.horizontalTextPadding = Constants.padding / 2,
      this.shapeRadius,
      this.disabledColor,
      this.widget,
      this.fontWeight,
      required this.icon,
      this.textDirection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(elevation),
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
            horizontal: horizontalTextPadding, vertical: verticalTextPadding)),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return backgroundColor.withOpacity(0.9);
            } else if (states.contains(MaterialState.disabled)) {
              return AppColors.gray;
            }
            return backgroundColor;
          },
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                side: BorderSide(color: borderColor ?? Colors.transparent),
                borderRadius: BorderRadius.circular(10))),
      ),
      label: widget ??
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalTextPadding,
                vertical: verticalTextPadding),
            child: TextWidget(
              title!,
              textDirection: textDirection,
              color: textColor ?? AppColors.black,
              fontSize: fontSize ?? 16,
              fontWeight: fontWeight ?? FontWeight.normal,
            ),
          ),
      onPressed: onPressed,
      icon: icon,
    );
  }
}
