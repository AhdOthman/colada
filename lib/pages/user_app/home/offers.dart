import 'package:coladaapp/models/offers/offers_model.dart';
import 'package:coladaapp/utils/constants/constants.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:coladaapp/widgets/network_image_widget.dart';
import 'package:coladaapp/widgets/text_widget.dart';
import 'package:coladaapp/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Offers extends StatelessWidget {
  final OffersModel offersModel;
  const Offers({Key? key, required this.offersModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final time = offersModel.timings!.isNotEmpty
        ? "${offersModel.timings!.first.startingTime} - ${offersModel.timings!.first.endingTime}"
        : "Not Available";
    return Row(
      children: [
        ClipRRect(
          child: NetworkImageWidget(
            offersModel.photo ??
                'https://g5g5new.s3.eu-west-2.amazonaws.com/2021/06/131391081_842368429665957_5677427331423131691_n.jpg',
            height: 100,
            width: 100,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        const SizedBox(
          width: Constants.padding,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: Constants.padding / 2,
              ),
              TitleWidget(offersModel.name!),
              const SizedBox(
                height: Constants.padding / 2,
              ),
              TextWidget(
                offersModel.details?.en ?? "No description found",
                maxLines: 2,
                color: AppColors.gray,
              ),
              const SizedBox(
                height: Constants.padding / 2,
              ),
              Row(
                children: [
                  SvgPicture.asset('assets/icons/clock_icon.svg'),
                  const SizedBox(
                    width: Constants.padding / 2,
                  ),
                  TextWidget(time),
                ],
              ),
              const SizedBox(
                height: Constants.padding / 2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
