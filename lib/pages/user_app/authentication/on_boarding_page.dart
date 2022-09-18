import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:coladaapp/generated/locale_keys.g.dart';
import 'package:coladaapp/routes/routes.gr.dart';
import 'package:coladaapp/utils/constants/constants.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:coladaapp/widgets/button_widget.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    context.router.push(LoginRoute());
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 16.0);
    final size = MediaQuery.of(context).size;

    var pageDecoration = PageDecoration(
      titleTextStyle:
          const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
      bodyTextStyle: bodyStyle,
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
      footerPadding: EdgeInsets.only(top: size.height * 0.2, bottom: 16),
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,

      pages: [
        PageViewModel(
          title: LocaleKeys.offer_title_benefit.tr(),
          body:
              "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore.",
          image: _buildImage('splash1.png'),
          decoration: pageDecoration,
          footer: SizedBox(
              width: size.width * 0.9,
              child: ButtonWidget(
                title: LocaleKeys.next_button.tr(),
                onPressed: () => introKey.currentState?.animateScroll(1),
                backgroundColor: AppColors.primaryColor,
                textColor: AppColors.black,
              )),
        ),
        PageViewModel(
          title: "BROWSE OUR OFFERS",
          body:
              "Get access to exclusive discounts\n That can get up to 50%. \n",
          image: _buildImage('splash2.png'),
          decoration: pageDecoration,
          footer: SizedBox(
              width: size.width * 0.9,
              child: ButtonWidget(
                title: LocaleKeys.next_button.tr(),
                onPressed: () => introKey.currentState?.animateScroll(2),
                backgroundColor: AppColors.primaryColor,
                textColor: AppColors.black,
              )),
        ),
        PageViewModel(
          title: "WITH A SIMPLE SCAN",
          body:
              "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore.",
          image: _buildImage('splash3.png'),
          decoration: pageDecoration,
          footer: SizedBox(
              width: size.width * 0.9,
              child: ButtonWidget(
                title: LocaleKeys.finish_button.tr(),
                onPressed: () => context.router.replace(LoginRoute()),
                backgroundColor: AppColors.primaryColor,
                textColor: AppColors.black,
              )),
        ),
      ],
      onDone: () => context.router.replace(LoginRoute()),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipFlex: 0,
      nextFlex: 0,
      dotsFlex: 0,

      isProgressTap: false,
      showDoneButton: false,
      showNextButton: false,

      curve: Curves.fastLinearToSlowEaseIn,

      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: AppColors.white,
        activeSize: Size(22.0, 10.0),
        activeColor: AppColors.white,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
