import 'dart:convert';

import 'package:coladaapp/generated/locale_keys.g.dart';
import 'package:coladaapp/models/user/user_location_model.dart';
import 'package:coladaapp/provider/user/user_provider.dart';
import 'package:coladaapp/routes/routes.gr.dart';
import 'package:coladaapp/utils/constants/constants.dart';
import 'package:coladaapp/utils/constants/keys.dart';
import 'package:coladaapp/utils/current_location.dart';
import 'package:coladaapp/utils/failure.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:coladaapp/utils/ui_helper.dart';
import 'package:coladaapp/widgets/app_bar_widget.dart';
import 'package:coladaapp/widgets/button_icon_widget.dart';
import 'package:coladaapp/widgets/loading_dialog.dart';
import 'package:coladaapp/widgets/text_widget.dart';
import 'package:coladaapp/widgets/title_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as easy_localization;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_route/auto_route.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocationPage extends ConsumerStatefulWidget {
  const UserLocationPage({Key? key}) : super(key: key);

  @override
  _UserLocationPageState createState() => _UserLocationPageState();
}

class _UserLocationPageState extends ConsumerState<UserLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
          leading: IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              // context.router.replaceAll(const [BottomNavigationRoute()]);
            },
          ),
          backColor: Colors.white,
          actions: [
            CupertinoButton(
              onPressed: () {
                // context.router.replaceAll(const [BottomNavigationRoute()]);
              },
              child: TextWidget(
                "skip".tr(),
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              ListView(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Constants.padding,
                          vertical: Constants.padding),
                      child: TitleWidget(
                        LocaleKeys.finding_restaurants_near_you_title.tr(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Constants.padding,
                      ),
                      child: TextWidget(
                        LocaleKeys.find_restaurants_location_statement.tr(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: Constants.padding * 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Constants.padding,
                    ),
                    child: ButtonIconWidget(
                      title: LocaleKeys.ask_adders.tr(),
                      backgroundColor: AppColors.white,
                      onPressed: () async {
                        try {
                          List location =
                              await context.router.push(const MapPickerRoute())
                                  as List<UserLocationModel>;
                          _updateUserLocation(location.first);
                        } catch (e) {
                          UIHelper.showNotification(
                              'Can not pick the location');
                        }
                      },
                      icon: SvgPicture.asset('assets/icons/location_icon.svg'),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: Constants.padding,
                right: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Constants.padding,
                  ),
                  child: ButtonIconWidget(
                    title: LocaleKeys.use_current_location_title.tr(),
                    onPressed: _getCurrentLocation,
                    icon: SvgPicture.asset(
                        'assets/icons/current_location_icon.svg'),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future _getCurrentLocation() async {
    try {
      final result = await CurrentLocation.fetch();
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(result.latitude, result.longitude);
      _updateUserLocation(UserLocationModel(
        lat: result.latitude.toString(),
        lng: result.longitude.toString(),
        city: placeMarks.first.locality,
        address: placeMarks.first.street,
      ));
    } catch (e) {
      debugPrint('error $e');
    }
  }

  Future _updateUserLocation(UserLocationModel location) async {
    try {
      final userProv = ref.read(userProvider);
      loadingDialog(context);
      print(userProv.user!.email);
      var response = await userProv.updateUser(userProv.user!.id!, location);

      Navigator.pop(context);
      if (response) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString(Keys.hasSaveUserData,
            json.encoder.convert(userProv.user!.toJson()));
        context.router.push(BottomNavigationRoute());
      }
    } on Failure {
      debugPrint('error update user');
      Navigator.pop(context);
    }
  }
}
