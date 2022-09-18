import 'package:coladaapp/utils/constants/constants.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:coladaapp/widgets/network_image_widget.dart';
import 'package:coladaapp/widgets/text_widget.dart';
import 'package:coladaapp/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class FeaturedPartners extends StatelessWidget {
  final String image;
  final String name;
  final num distance;
  final num rate;
  final String id;
  final List<String> cuisines;

  const FeaturedPartners(
      {Key? key,
      required this.image,
      required this.name,
      required this.distance,
      required this.rate,
      required this.cuisines,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Constants.padding / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: Hero(
                tag: id,
                child: NetworkImageWidget(
                  image,
                  height: 160,
                  width: 200,
                ),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(
              height: Constants.padding / 2,
            ),
            TitleWidget(name),
            const SizedBox(
              height: Constants.padding / 2,
            ),
            TextWidget(
              cuisines.join(','),
              color: AppColors.gray,
            ),
            const SizedBox(
              height: Constants.padding / 2,
            ),
            Row(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Constants.padding,
                        vertical: Constants.padding / 2),
                    child: TextWidget('$rate'),
                  ),
                  color: AppColors.primaryColor,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Constants.padding,
                  ),
                  child: TextWidget('$distance'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
