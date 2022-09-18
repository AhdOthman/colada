import 'package:coladaapp/utils/constants/constants.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:coladaapp/widgets/slider_widget.dart';
import 'package:coladaapp/widgets/subtitle_widget.dart';
import 'package:coladaapp/widgets/text_widget.dart';
import 'package:coladaapp/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class Restaurants extends ConsumerWidget {
  final List<String> photos;
  final String name;
  final List<String> cuisines;
  final num distance;
  final num coladaRate;
  final int rating;
  const Restaurants(
      {Key? key,
      required this.photos,
      required this.name,
      required this.cuisines,
      required this.distance,
      required this.rating,
      required this.coladaRate})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Constants.padding, vertical: Constants.padding / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SliderWidget(photos: photos),
            const SizedBox(
              height: Constants.padding / 2,
            ),
            TitleWidget(name),
            const SizedBox(
              height: Constants.padding / 2,
            ),
            TextWidget(
              cuisines.join(' * '),
              color: AppColors.gray,
            ),
            const SizedBox(
              height: Constants.padding / 2,
            ),
            Row(
              children: [
                SvgPicture.asset('assets/icons/star_icon.svg'),
                SubtitleWidget('$rating'),
                const SizedBox(
                  width: Constants.padding,
                ),
                SvgPicture.asset('assets/icons/location_icon.svg'),
                SubtitleWidget('$distance Km'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
