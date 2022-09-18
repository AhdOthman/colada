import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:coladaapp/generated/locale_keys.g.dart';
import 'package:coladaapp/models/visits/user_visits_model.dart';
import 'package:coladaapp/provider/visit/visit_provider.dart';
import 'package:coladaapp/routes/routes.gr.dart';
import 'package:coladaapp/utils/card_clipper.dart';
import 'package:coladaapp/utils/constants/constants.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:coladaapp/widgets/network_image_widget.dart';
import 'package:coladaapp/widgets/subtitle_widget.dart';
import 'package:coladaapp/widgets/text_widget.dart';
import 'package:coladaapp/widgets/title_widget.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VisitRestaurant extends ConsumerWidget {
  final UserVisits? userVisits;
  final UserVisits? currentVisits;
  final bool? isHomePage;
  final bool? isOrderDetails;
  const VisitRestaurant(
      {Key? key,
      this.userVisits,
      this.currentVisits,
      this.isHomePage,
      this.isOrderDetails = false})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        if (isHomePage == true) {
          ref.watch(visitProvider).clieckUserVisits = currentVisits;

          context.router.push(OrderDetailsPageRoute(userVisits: currentVisits));
        } else if (isOrderDetails == false) {
          ref.watch(visitProvider).clieckUserVisits = userVisits;

          context.router.push(OrderDetailsPageRoute(userVisits: userVisits));
        }
      },
      child: Card(
          elevation: 5,
          child: Column(
            children: [
              ListTile(
                dense: true,
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: NetworkImageWidget(
                    isHomePage!
                        ? currentVisits!.sid!.photos![0]
                        : userVisits!.sid!.photos![0],
                  ),
                ),
                title: ListTile(
                  title: TextWidget(
                    isHomePage!
                        ? currentVisits!.sid!.name!
                        : userVisits!.sid!.name!,
                    fontSize: 20,
                  ),
                  contentPadding: EdgeInsets.zero,
                  trailing: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: AppColors.green,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Constants.padding,
                          vertical: Constants.padding / 4),
                      child: SubtitleWidget(
                        isHomePage!
                            ? currentVisits!.status!
                            : userVisits!.status!,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                        child: SubtitleWidget(
                      isHomePage!
                          ? currentVisits!.sid!.cuisines!.join('* ')
                          : userVisits!.sid!.cuisines!.join('* '),
                      color: AppColors.gray,
                    )),
                    const SizedBox(
                      height: Constants.padding / 2,
                    ),
                    Row(
                      children: [
                        SubtitleWidget(isHomePage!
                            ? currentVisits!.sid!.rating!.toString()
                            : userVisits!.sid!.rating!.toString()),
                        const SizedBox(
                          width: Constants.padding / 2,
                        ),
                        SvgPicture.asset('assets/icons/star_icon.svg'),
                        const SizedBox(
                          width: Constants.padding / 2,
                        ),
                        const SubtitleWidget('+200 rating'),
                      ],
                    ),
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Constants.padding / 2),
                  child: ClipPath(
                    clipper: CardClipper(8),
                    child: Card(
                      color: AppColors.primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Constants.padding * 2,
                            vertical: Constants.padding / 2),
                        child: TitleWidget(
                          'XF2345',
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
