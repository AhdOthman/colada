import 'package:auto_route/auto_route.dart';
import 'package:coladaapp/generated/locale_keys.g.dart';
import 'package:coladaapp/routes/routes.gr.dart';
import 'package:coladaapp/utils/constants/constants.dart';
import 'package:coladaapp/widgets/app_bar_widget.dart';
import 'package:coladaapp/widgets/button_widget.dart';
import 'package:coladaapp/widgets/text_widget.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QRScanner extends StatelessWidget {
  const QRScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Scanner',
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: Constants.padding,
              right: 0,
              left: 0,
              child: TextWidget(
                LocaleKeys.scan_instructions.tr(),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Constants.padding,
                  ),
                  child: SvgPicture.asset('assets/images/qr_image.svg'),
                )),
            Positioned(
              bottom: Constants.padding,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Constants.padding,
                ),
                child: ButtonWidget(
                  title: LocaleKeys.scan_user_confirmation.tr(),
                  onPressed: () {
                    context.router.replace(const QRCameraRoute());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
