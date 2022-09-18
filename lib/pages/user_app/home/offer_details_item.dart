import 'package:coladaapp/models/offers/offers_item.dart';
import 'package:coladaapp/models/offers/offers_model.dart';
import 'package:coladaapp/utils/constants/constants.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:coladaapp/widgets/network_image_widget.dart';
import 'package:coladaapp/widgets/text_widget.dart';
import 'package:coladaapp/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OffersDetailsItem extends StatelessWidget {
  final OfferItem offersModel;
  const OffersDetailsItem({Key? key, required this.offersModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          child: NetworkImageWidget(
            offersModel.itemPhoto ??
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
              TitleWidget(offersModel.itemName!),
              const SizedBox(
                height: Constants.padding / 2,
              ),
              TextWidget(
                offersModel.itemDescription ?? "No description found",
                maxLines: 2,
                color: AppColors.gray,
              ),
              const SizedBox(
                height: Constants.padding / 2,
              ),
              TextWidget("${offersModel.itemPrice} SAR"),
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
