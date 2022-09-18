import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          color: Colors.transparent,
          height: 45,
          width: 45,
          child: const LoadingIndicator(
            indicatorType: Indicator.ballClipRotate,
            colors: [AppColors.primaryColor],
            strokeWidth: 5,
          )),
    );
  }
}
