// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i28;
import 'package:flutter/material.dart' as _i31;

import '../models/offers/offers_model.dart' as _i32;
import '../models/visits/user_visits_model.dart' as _i33;
import '../pages/map_picker/map_picker_page.dart' as _i12;
import '../pages/splash_screen.dart' as _i1;
import '../pages/user_app/authentication/login_page.dart' as _i2;
import '../pages/user_app/authentication/new_user_page.dart' as _i23;
import '../pages/user_app/authentication/on_boarding_page.dart' as _i18;
import '../pages/user_app/authentication/otp_page.dart' as _i4;
import '../pages/user_app/bottom_navigation_page.dart' as _i6;
import '../pages/user_app/home/activity_page.dart' as _i27;
import '../pages/user_app/home/all_feature_store_page.dart' as _i22;
import '../pages/user_app/home/all_store_page.dart' as _i21;
import '../pages/user_app/home/favourite_page.dart' as _i26;
import '../pages/user_app/home/filter_page.dart' as _i17;
import '../pages/user_app/home/home_page.dart' as _i25;
import '../pages/user_app/home/map_locator_page.dart' as _i13;
import '../pages/user_app/home/menu_webview_page.dart' as _i3;
import '../pages/user_app/home/offer_details.dart' as _i8;
import '../pages/user_app/home/order_details_page.dart' as _i20;
import '../pages/user_app/home/restaurant_details.dart' as _i7;
import '../pages/user_app/home/see_all_restaurant.dart' as _i16;
import '../pages/user_app/qr_scanner/qr_camera.dart' as _i10;
import '../pages/user_app/qr_scanner/qr_scanner.dart' as _i9;
import '../pages/user_app/qr_scanner/qr_store_offers_page.dart' as _i19;
import '../pages/user_app/user/account_settings_page.dart' as _i11;
import '../pages/user_app/user/cashback_history.dart' as _i30;
import '../pages/user_app/user/edit_profile_page.dart' as _i14;
import '../pages/user_app/user/faq_page.dart' as _i24;
import '../pages/user_app/user/notfifcations_page.dart' as _i15;
import '../pages/user_app/user/profile_page.dart' as _i29;
import '../pages/user_app/user/uesr_location_page.dart' as _i5;

class AppRouter extends _i28.RootStackRouter {
  AppRouter([_i31.GlobalKey<_i31.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i28.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashScreen());
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.LoginPage(key: args.key));
    },
    MenuRoute.name: (routeData) {
      final args = routeData.argsAs<MenuRouteArgs>();
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.MenuPage(key: args.key, webViewUrl: args.webViewUrl));
    },
    OtpRoute.name: (routeData) {
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.OtpPage());
    },
    UserLocationRoute.name: (routeData) {
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.UserLocationPage());
    },
    BottomNavigationRoute.name: (routeData) {
      final args = routeData.argsAs<BottomNavigationRouteArgs>(
          orElse: () => const BottomNavigationRouteArgs());
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.BottomNavigationPage(key: args.key, index: args.index));
    },
    RestaurantDetailsRoute.name: (routeData) {
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.RestaurantDetails());
    },
    OfferDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<OfferDetailsRouteArgs>();
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i8.OfferDetails(key: args.key, offersList: args.offersList));
    },
    QRScannerRoute.name: (routeData) {
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.QRScanner());
    },
    QRCameraRoute.name: (routeData) {
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.QRCamera());
    },
    AccountSettingsRoute.name: (routeData) {
      final args = routeData.argsAs<AccountSettingsRouteArgs>(
          orElse: () => const AccountSettingsRouteArgs());
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData, child: _i11.AccountSettingsPage(key: args.key));
    },
    MapPickerRoute.name: (routeData) {
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i12.MapPickerPage());
    },
    MapLocator.name: (routeData) {
      final args = routeData.argsAs<MapLocatorArgs>();
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i13.MapPage(key: args.key, lat: args.lat, long: args.long));
    },
    EditProfileRoute.name: (routeData) {
      final args = routeData.argsAs<EditProfileRouteArgs>(
          orElse: () => const EditProfileRouteArgs());
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData, child: _i14.EditProfilePage(key: args.key));
    },
    NotfifcationsRoute.name: (routeData) {
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i15.NotificationsPage());
    },
    SeeAllRestaurantRoute.name: (routeData) {
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i16.SeeAllRestaurant());
    },
    FilterRoute.name: (routeData) {
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i17.FilterPage());
    },
    OnBoardingPage.name: (routeData) {
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i18.OnBoardingPage());
    },
    QRStoreOffersPage.name: (routeData) {
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i19.QRStoreOffersPage());
    },
    OrderDetailsPageRoute.name: (routeData) {
      final args = routeData.argsAs<OrderDetailsPageRouteArgs>(
          orElse: () => const OrderDetailsPageRouteArgs());
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i20.OrderDetailsPage(
              key: args.key, userVisits: args.userVisits));
    },
    AllStorePageRoute.name: (routeData) {
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i21.AllStorePage());
    },
    AllFueatureStorePageRoute.name: (routeData) {
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i22.AllFueatureStorePage());
    },
    SignUpNewUserPageRoute.name: (routeData) {
      final args = routeData.argsAs<SignUpNewUserPageRouteArgs>(
          orElse: () => const SignUpNewUserPageRouteArgs());
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData, child: _i23.SignUpNewUserPage(key: args.key));
    },
    FagPageRoute.name: (routeData) {
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i24.FagPage());
    },
    HomeRoute.name: (routeData) {
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i25.HomePage());
    },
    FavouriteRoute.name: (routeData) {
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i26.FavouritePage());
    },
    ActivityRoute.name: (routeData) {
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i27.ActivityPage());
    },
    ProfileRoute.name: (routeData) {
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i28.EmptyRouterPage());
    },
    ProfilePageRoute.name: (routeData) {
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i29.ProfilePage());
    },
    CashbackHistoryRoute.name: (routeData) {
      return _i28.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i30.CashbackHistory());
    }
  };

  @override
  List<_i28.RouteConfig> get routes => [
        _i28.RouteConfig(SplashRoute.name, path: '/'),
        _i28.RouteConfig(LoginRoute.name, path: '/login'),
        _i28.RouteConfig(MenuRoute.name, path: 'menu-webview'),
        _i28.RouteConfig(OtpRoute.name, path: '/otp'),
        _i28.RouteConfig(UserLocationRoute.name, path: '/user-location'),
        _i28.RouteConfig(BottomNavigationRoute.name,
            path: '/bottom-navigation-page',
            children: [
              _i28.RouteConfig(HomeRoute.name,
                  path: 'home', parent: BottomNavigationRoute.name),
              _i28.RouteConfig(FavouriteRoute.name,
                  path: 'favourite', parent: BottomNavigationRoute.name),
              _i28.RouteConfig(ActivityRoute.name,
                  path: 'activity', parent: BottomNavigationRoute.name),
              _i28.RouteConfig(ProfileRoute.name,
                  path: 'profile',
                  parent: BottomNavigationRoute.name,
                  children: [
                    _i28.RouteConfig(ProfilePageRoute.name,
                        path: '', parent: ProfileRoute.name),
                    _i28.RouteConfig(CashbackHistoryRoute.name,
                        path: '', parent: ProfileRoute.name)
                  ])
            ]),
        _i28.RouteConfig(RestaurantDetailsRoute.name,
            path: 'restaurant-details'),
        _i28.RouteConfig(OfferDetailsRoute.name, path: 'offer-details'),
        _i28.RouteConfig(QRScannerRoute.name, path: 'qr-scanner'),
        _i28.RouteConfig(QRCameraRoute.name, path: 'qr-camera'),
        _i28.RouteConfig(AccountSettingsRoute.name, path: 'account-settings'),
        _i28.RouteConfig(MapPickerRoute.name, path: 'map-picker'),
        _i28.RouteConfig(MapLocator.name, path: 'map-locator'),
        _i28.RouteConfig(EditProfileRoute.name, path: 'Edite-Profil'),
        _i28.RouteConfig(NotfifcationsRoute.name, path: 'Notfifcations-Page'),
        _i28.RouteConfig(SeeAllRestaurantRoute.name,
            path: 'See-All-Restaurant-Page'),
        _i28.RouteConfig(FilterRoute.name, path: 'Filter-Page'),
        _i28.RouteConfig(OnBoardingPage.name, path: 'On_Boarding_Page'),
        _i28.RouteConfig(QRStoreOffersPage.name, path: 'QR_Store_OffersPage'),
        _i28.RouteConfig(OrderDetailsPageRoute.name,
            path: 'Order_Details_Page'),
        _i28.RouteConfig(AllStorePageRoute.name, path: 'AllStorePage'),
        _i28.RouteConfig(AllFueatureStorePageRoute.name,
            path: 'AllFueatureStorePage'),
        _i28.RouteConfig(SignUpNewUserPageRoute.name,
            path: 'SignUp_New_User_Page'),
        _i28.RouteConfig(FagPageRoute.name, path: 'Fag_Page')
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashRoute extends _i28.PageRouteInfo<void> {
  const SplashRoute() : super(SplashRoute.name, path: '/');

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i28.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i31.Key? key})
      : super(LoginRoute.name, path: '/login', args: LoginRouteArgs(key: key));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.MenuPage]
class MenuRoute extends _i28.PageRouteInfo<MenuRouteArgs> {
  MenuRoute({_i31.Key? key, required String webViewUrl})
      : super(MenuRoute.name,
            path: 'menu-webview',
            args: MenuRouteArgs(key: key, webViewUrl: webViewUrl));

  static const String name = 'MenuRoute';
}

class MenuRouteArgs {
  const MenuRouteArgs({this.key, required this.webViewUrl});

  final _i31.Key? key;

  final String webViewUrl;

  @override
  String toString() {
    return 'MenuRouteArgs{key: $key, webViewUrl: $webViewUrl}';
  }
}

/// generated route for
/// [_i4.OtpPage]
class OtpRoute extends _i28.PageRouteInfo<void> {
  const OtpRoute() : super(OtpRoute.name, path: '/otp');

  static const String name = 'OtpRoute';
}

/// generated route for
/// [_i5.UserLocationPage]
class UserLocationRoute extends _i28.PageRouteInfo<void> {
  const UserLocationRoute()
      : super(UserLocationRoute.name, path: '/user-location');

  static const String name = 'UserLocationRoute';
}

/// generated route for
/// [_i6.BottomNavigationPage]
class BottomNavigationRoute
    extends _i28.PageRouteInfo<BottomNavigationRouteArgs> {
  BottomNavigationRoute(
      {_i31.Key? key, int? index, List<_i28.PageRouteInfo>? children})
      : super(BottomNavigationRoute.name,
            path: '/bottom-navigation-page',
            args: BottomNavigationRouteArgs(key: key, index: index),
            initialChildren: children);

  static const String name = 'BottomNavigationRoute';
}

class BottomNavigationRouteArgs {
  const BottomNavigationRouteArgs({this.key, this.index});

  final _i31.Key? key;

  final int? index;

  @override
  String toString() {
    return 'BottomNavigationRouteArgs{key: $key, index: $index}';
  }
}

/// generated route for
/// [_i7.RestaurantDetails]
class RestaurantDetailsRoute extends _i28.PageRouteInfo<void> {
  const RestaurantDetailsRoute()
      : super(RestaurantDetailsRoute.name, path: 'restaurant-details');

  static const String name = 'RestaurantDetailsRoute';
}

/// generated route for
/// [_i8.OfferDetails]
class OfferDetailsRoute extends _i28.PageRouteInfo<OfferDetailsRouteArgs> {
  OfferDetailsRoute({_i31.Key? key, required _i32.OffersModel offersList})
      : super(OfferDetailsRoute.name,
            path: 'offer-details',
            args: OfferDetailsRouteArgs(key: key, offersList: offersList));

  static const String name = 'OfferDetailsRoute';
}

class OfferDetailsRouteArgs {
  const OfferDetailsRouteArgs({this.key, required this.offersList});

  final _i31.Key? key;

  final _i32.OffersModel offersList;

  @override
  String toString() {
    return 'OfferDetailsRouteArgs{key: $key, offersList: $offersList}';
  }
}

/// generated route for
/// [_i9.QRScanner]
class QRScannerRoute extends _i28.PageRouteInfo<void> {
  const QRScannerRoute() : super(QRScannerRoute.name, path: 'qr-scanner');

  static const String name = 'QRScannerRoute';
}

/// generated route for
/// [_i10.QRCamera]
class QRCameraRoute extends _i28.PageRouteInfo<void> {
  const QRCameraRoute() : super(QRCameraRoute.name, path: 'qr-camera');

  static const String name = 'QRCameraRoute';
}

/// generated route for
/// [_i11.AccountSettingsPage]
class AccountSettingsRoute
    extends _i28.PageRouteInfo<AccountSettingsRouteArgs> {
  AccountSettingsRoute({_i31.Key? key})
      : super(AccountSettingsRoute.name,
            path: 'account-settings', args: AccountSettingsRouteArgs(key: key));

  static const String name = 'AccountSettingsRoute';
}

class AccountSettingsRouteArgs {
  const AccountSettingsRouteArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'AccountSettingsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i12.MapPickerPage]
class MapPickerRoute extends _i28.PageRouteInfo<void> {
  const MapPickerRoute() : super(MapPickerRoute.name, path: 'map-picker');

  static const String name = 'MapPickerRoute';
}

/// generated route for
/// [_i13.MapPage]
class MapLocator extends _i28.PageRouteInfo<MapLocatorArgs> {
  MapLocator({_i31.Key? key, required double lat, required double long})
      : super(MapLocator.name,
            path: 'map-locator',
            args: MapLocatorArgs(key: key, lat: lat, long: long));

  static const String name = 'MapLocator';
}

class MapLocatorArgs {
  const MapLocatorArgs({this.key, required this.lat, required this.long});

  final _i31.Key? key;

  final double lat;

  final double long;

  @override
  String toString() {
    return 'MapLocatorArgs{key: $key, lat: $lat, long: $long}';
  }
}

/// generated route for
/// [_i14.EditProfilePage]
class EditProfileRoute extends _i28.PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({_i31.Key? key})
      : super(EditProfileRoute.name,
            path: 'Edite-Profil', args: EditProfileRouteArgs(key: key));

  static const String name = 'EditProfileRoute';
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i15.NotificationsPage]
class NotfifcationsRoute extends _i28.PageRouteInfo<void> {
  const NotfifcationsRoute()
      : super(NotfifcationsRoute.name, path: 'Notfifcations-Page');

  static const String name = 'NotfifcationsRoute';
}

/// generated route for
/// [_i16.SeeAllRestaurant]
class SeeAllRestaurantRoute extends _i28.PageRouteInfo<void> {
  const SeeAllRestaurantRoute()
      : super(SeeAllRestaurantRoute.name, path: 'See-All-Restaurant-Page');

  static const String name = 'SeeAllRestaurantRoute';
}

/// generated route for
/// [_i17.FilterPage]
class FilterRoute extends _i28.PageRouteInfo<void> {
  const FilterRoute() : super(FilterRoute.name, path: 'Filter-Page');

  static const String name = 'FilterRoute';
}

/// generated route for
/// [_i18.OnBoardingPage]
class OnBoardingPage extends _i28.PageRouteInfo<void> {
  const OnBoardingPage() : super(OnBoardingPage.name, path: 'On_Boarding_Page');

  static const String name = 'OnBoardingPage';
}

/// generated route for
/// [_i19.QRStoreOffersPage]
class QRStoreOffersPage extends _i28.PageRouteInfo<void> {
  const QRStoreOffersPage()
      : super(QRStoreOffersPage.name, path: 'QR_Store_OffersPage');

  static const String name = 'QRStoreOffersPage';
}

/// generated route for
/// [_i20.OrderDetailsPage]
class OrderDetailsPageRoute
    extends _i28.PageRouteInfo<OrderDetailsPageRouteArgs> {
  OrderDetailsPageRoute({_i31.Key? key, _i33.UserVisits? userVisits})
      : super(OrderDetailsPageRoute.name,
            path: 'Order_Details_Page',
            args: OrderDetailsPageRouteArgs(key: key, userVisits: userVisits));

  static const String name = 'OrderDetailsPageRoute';
}

class OrderDetailsPageRouteArgs {
  const OrderDetailsPageRouteArgs({this.key, this.userVisits});

  final _i31.Key? key;

  final _i33.UserVisits? userVisits;

  @override
  String toString() {
    return 'OrderDetailsPageRouteArgs{key: $key, userVisits: $userVisits}';
  }
}

/// generated route for
/// [_i21.AllStorePage]
class AllStorePageRoute extends _i28.PageRouteInfo<void> {
  const AllStorePageRoute()
      : super(AllStorePageRoute.name, path: 'AllStorePage');

  static const String name = 'AllStorePageRoute';
}

/// generated route for
/// [_i22.AllFueatureStorePage]
class AllFueatureStorePageRoute extends _i28.PageRouteInfo<void> {
  const AllFueatureStorePageRoute()
      : super(AllFueatureStorePageRoute.name, path: 'AllFueatureStorePage');

  static const String name = 'AllFueatureStorePageRoute';
}

/// generated route for
/// [_i23.SignUpNewUserPage]
class SignUpNewUserPageRoute
    extends _i28.PageRouteInfo<SignUpNewUserPageRouteArgs> {
  SignUpNewUserPageRoute({_i31.Key? key})
      : super(SignUpNewUserPageRoute.name,
            path: 'SignUp_New_User_Page',
            args: SignUpNewUserPageRouteArgs(key: key));

  static const String name = 'SignUpNewUserPageRoute';
}

class SignUpNewUserPageRouteArgs {
  const SignUpNewUserPageRouteArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'SignUpNewUserPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i24.FagPage]
class FagPageRoute extends _i28.PageRouteInfo<void> {
  const FagPageRoute() : super(FagPageRoute.name, path: 'Fag_Page');

  static const String name = 'FagPageRoute';
}

/// generated route for
/// [_i25.HomePage]
class HomeRoute extends _i28.PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: 'home');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i26.FavouritePage]
class FavouriteRoute extends _i28.PageRouteInfo<void> {
  const FavouriteRoute() : super(FavouriteRoute.name, path: 'favourite');

  static const String name = 'FavouriteRoute';
}

/// generated route for
/// [_i27.ActivityPage]
class ActivityRoute extends _i28.PageRouteInfo<void> {
  const ActivityRoute() : super(ActivityRoute.name, path: 'activity');

  static const String name = 'ActivityRoute';
}

/// generated route for
/// [_i28.EmptyRouterPage]
class ProfileRoute extends _i28.PageRouteInfo<void> {
  const ProfileRoute({List<_i28.PageRouteInfo>? children})
      : super(ProfileRoute.name, path: 'profile', initialChildren: children);

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i29.ProfilePage]
class ProfilePageRoute extends _i28.PageRouteInfo<void> {
  const ProfilePageRoute() : super(ProfilePageRoute.name, path: '');

  static const String name = 'ProfilePageRoute';
}

/// generated route for
/// [_i30.CashbackHistory]
class CashbackHistoryRoute extends _i28.PageRouteInfo<void> {
  const CashbackHistoryRoute() : super(CashbackHistoryRoute.name, path: '');

  static const String name = 'CashbackHistoryRoute';
}
