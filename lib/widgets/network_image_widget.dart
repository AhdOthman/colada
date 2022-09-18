import 'package:cached_network_image/cached_network_image.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final Color? imageColor;
  final double height;
  final double? width;
  final BoxFit boxFit;
  final BoxShape shape;

  const NetworkImageWidget(this.imageUrl,
      {Key? key,
      this.imageColor,
      this.height = 50,
      this.width = 50,
      this.shape = BoxShape.rectangle,
      this.boxFit = BoxFit.cover})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => const Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: LoadingIndicator(
                  indicatorType: Indicator.circleStrokeSpin,
                  colors: [AppColors.primaryColor],
                  strokeWidth: 3,
                ),
              ),
            ),
        imageBuilder: (context, imageProvider) => Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                shape: shape,
                image: DecorationImage(
                  image: imageProvider,
                  fit: boxFit,
                ),
              ),
            ),
        errorWidget: (context, url, error) => const Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: LoadingIndicator(
                  indicatorType: Indicator.circleStrokeSpin,
                  colors: [AppColors.primaryColor],
                  strokeWidth: 3,
                ),
              ),
            ),
        height: height,
        width: width,
        fit: boxFit,
        color: imageColor);
  }
}
