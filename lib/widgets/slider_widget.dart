import 'package:carousel_slider/carousel_slider.dart';
import 'package:coladaapp/utils/constants/constants.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'network_image_widget.dart';

class SliderWidget extends ConsumerWidget {
  final double height;
  final List<String> photos;
  final double? circularNum;
  final _indexProvider = StateProvider.autoDispose<int>((ref) => 0);
  SliderWidget(
      {this.circularNum, this.height = 185.0, Key? key, required this.photos})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(circularNum ?? 0),
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            CarouselSlider.builder(
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return NetworkImageWidget(
                  photos[index],
                  height: 185,
                  width: MediaQuery.of(context).size.width,
                );
              },
              options: CarouselOptions(
                  autoPlayInterval: const Duration(seconds: 2),
                  autoPlay: true,
                  enlargeCenterPage: false,
                  viewportFraction: 1,
                  // aspectRatio: 2.0,
                  initialPage: 0,
                  onPageChanged: (index, reason) {
                    ref.read(_indexProvider.state).state = index;
                  },
                  disableCenter: true),
              itemCount: photos.length,
            ),
            PositionedDirectional(
              bottom: Constants.padding,
              end: Constants.padding,
              child: Consumer(
                builder: (context, ref, child) {
                  final activeIndex = ref.watch(_indexProvider);
                  return AnimatedSmoothIndicator(
                    count: photos.length,
                    effect: SlideEffect(
                        spacing: 8.0,
                        radius: 4.0,
                        dotWidth: 10.0,
                        dotHeight: 5.0,
                        paintStyle: PaintingStyle.fill,
                        strokeWidth: 1,
                        dotColor: AppColors.white.withOpacity(0.5),
                        activeDotColor: AppColors.white),
                    activeIndex: activeIndex,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
