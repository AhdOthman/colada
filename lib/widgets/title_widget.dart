import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final double? fontSize;
  final TextOverflow? overflow;
  final Color? color;
  final FontWeight? fontWeight;
  final String? fontFamily;

  TitleWidget(this.title,
      {Key? key,
      this.textAlign,
      this.textDirection,
      this.fontSize,
      this.overflow,
      this.fontWeight,
      this.fontFamily,
      this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.caption!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize ?? 24,
          fontFamily: fontFamily ?? 'SfPro'),
      textAlign: textAlign ?? TextAlign.start,
      textDirection: textDirection,
      overflow: overflow ?? TextOverflow.visible,
    );
  }
}
