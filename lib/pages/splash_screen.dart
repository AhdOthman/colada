import 'dart:async';
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:coladaapp/models/user/user_model.dart';
import 'package:coladaapp/provider/user/user_provider.dart';
import 'package:coladaapp/routes/routes.gr.dart';
import 'package:coladaapp/utils/constants/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  // prefs.setString(Keys.hasSaveUserData,
  //     json.encoder.convert(userProv.user!.toJson()));
  // context.router.push(const BottomNavigationRoute());

  _init() async {
    SharedPreferences? _prefs = await SharedPreferences.getInstance();

    if (_prefs.getBool("firstTime") == null) {
      _prefs.setBool("firstTime", true);
      Timer(const Duration(milliseconds: 2000),
          () => context.router.replace(const OnBoardingPage()));
    } else {
      Timer(const Duration(milliseconds: 2000), () {
        if (_prefs.getString(Keys.hasSaveUserData) == null) {
          context.router.replace(LoginRoute());
        } else {
          print(_prefs.getString(Keys.hasSaveUserData));
          var user = UserModel.fromJson(
              json.decode(_prefs.getString(Keys.hasSaveUserData)!));
          final userProv = ref.watch(userProvider);
          userProv.setUser(user);

          context.router.replace(BottomNavigationRoute());
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SvgPicture.asset('assets/images/logo.svg')),
    );
  }
}
