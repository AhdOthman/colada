import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:coladaapp/routes/routes.gr.dart';
import 'package:coladaapp/utils/constants/constants.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigationPage extends StatefulWidget {
  int? index;
  BottomNavigationPage({Key? key, this.index}) : super(key: key);

  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
  late CurvedAnimation curve;
  final iconList = <String>[
    'home_icon',
    'favorites_icon',
    'activity_icon',
    'profile_icon',
  ];
  @override
  void didUpdateWidget(covariant BottomNavigationPage oldWidget) {
    print("updated");

    super.didUpdateWidget(oldWidget);
  }

  int bottomNavIndex = 0; //default index of a first screen

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      const Duration(milliseconds: 200),
      () => _animationController.forward(),
    );
    super.initState();
  }

  bool init = true;
  @override
  void didChangeDependencies() {
    if (init) {
      bottomNavIndex = widget.index ?? 0;
      setState(() {
        init = !init;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      extendBody: true,
      inheritNavigatorObservers: false,
      routes: const [
        HomeRoute(),
        FavouriteRoute(),
        ActivityRoute(),
        ProfileRoute(),
      ],
      floatingActionButton: ScaleTransition(
        scale: animation,
        child: FloatingActionButton(
          elevation: 1,
          backgroundColor: AppColors.primaryColor,
          child: SvgPicture.asset('assets/icons/scan_icon.svg'),
          onPressed: () {
            context.router.push(const QRScannerRoute());
            // _animationController.reset();
            // _animationController.forward();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBuilder: (_, tabsRouter) {
        return AnimatedBottomNavigationBar.builder(
          onTap: (value) {
            print(value);
            setState(() {
              bottomNavIndex = value;
              tabsRouter.setActiveIndex(bottomNavIndex, notify: true);
            });
          },
          itemCount: iconList.length,
          activeIndex: bottomNavIndex,
          notchAndCornersAnimation: animation,
          splashSpeedInMilliseconds: 150,
          notchSmoothness: NotchSmoothness.softEdge,
          gapLocation: GapLocation.center,
          leftCornerRadius: 0,
          rightCornerRadius: 0,
          tabBuilder: (int index, bool isActive) {
            return Padding(
              padding: const EdgeInsets.all(Constants.padding),
              child: SvgPicture.asset(
                'assets/icons/${iconList[index]}.svg',
                color: isActive ? AppColors.primaryColor : AppColors.black,
              ),
            );
          },
        );
      },
    );
  }
}
