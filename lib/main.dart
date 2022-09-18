import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'routes/routes.gr.dart';
import 'utils/constants/keys.dart';
import 'utils/get_device_id.dart';
import 'utils/theme/styling.dart';

late SharedPreferences prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();
  prefs.setString(Keys.deviceIdKey, await GetDeviceId.getDeviceDetails());
  final List<Locale> systemLocales = window.locales;
  String languageCode = systemLocales.first.languageCode;
  Locale locale = languageCode == "en" || languageCode == "ar"
      ? Locale(languageCode)
      : const Locale("en");
  runApp(
    ProviderScope(
      child: EasyLocalization(
          supportedLocales: const [
            Locale(
              'ar',
            ),
            Locale(
              'en',
            )
          ],
          path: 'i18n', // <-- change the path of the translation files
          fallbackLocale: locale,
          child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Listener(
      onPointerUp: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      child: OverlaySupport.global(
        child: RestartWidget(
          child: MaterialApp.router(
            builder: (context, widget) => ResponsiveWrapper.builder(
              ClampingScrollWrapper.builder(context, widget!),
              breakpoints: const [
                ResponsiveBreakpoint.resize(480, name: PHONE),
                ResponsiveBreakpoint.resize(800, name: MOBILE),
                ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                ResponsiveBreakpoint.resize(2460, name: DESKTOP),
              ],
            ),
            debugShowCheckedModeBanner: false,
            title: 'Colada',
            theme: AppTheme.lightAppTheme,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
          ),
        ),
      ),
    );
  }
}

class RestartWidget extends StatefulWidget {
  const RestartWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
