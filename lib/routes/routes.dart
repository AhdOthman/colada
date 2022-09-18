import 'package:auto_route/auto_route.dart';
import 'package:coladaapp/pages/map_picker/map_picker_page.dart';
import 'package:coladaapp/pages/splash_screen.dart';
import 'package:coladaapp/pages/user_app/home/activity_page.dart';
import 'package:coladaapp/pages/user_app/authentication/login_page.dart';
import 'package:coladaapp/pages/user_app/authentication/new_user_page.dart';
import 'package:coladaapp/pages/user_app/authentication/on_boarding_page.dart';
import 'package:coladaapp/pages/user_app/authentication/otp_page.dart';
import 'package:coladaapp/pages/user_app/bottom_navigation_page.dart';
import 'package:coladaapp/pages/user_app/home/favourite_page.dart';
import 'package:coladaapp/pages/user_app/home/all_feature_store_page.dart';
import 'package:coladaapp/pages/user_app/home/all_store_page.dart';
import 'package:coladaapp/pages/user_app/home/filter_page.dart';
import 'package:coladaapp/pages/user_app/home/home_page.dart';
import 'package:coladaapp/pages/user_app/home/map_locator_page.dart';
import 'package:coladaapp/pages/user_app/home/menu_webview_page.dart';
import 'package:coladaapp/pages/user_app/home/offer_details.dart';
import 'package:coladaapp/pages/user_app/home/order_details_page.dart';
import 'package:coladaapp/pages/user_app/home/restaurant_details.dart';
import 'package:coladaapp/pages/user_app/home/see_all_restaurant.dart';
import 'package:coladaapp/pages/user_app/qr_scanner/qr_camera.dart';
import 'package:coladaapp/pages/user_app/qr_scanner/qr_scanner.dart';
import 'package:coladaapp/pages/user_app/qr_scanner/qr_store_offers_page.dart';
import 'package:coladaapp/pages/user_app/user/account_settings_page.dart';
import 'package:coladaapp/pages/user_app/user/cashback_history.dart';
import 'package:coladaapp/pages/user_app/user/edit_profile_page.dart';
import 'package:coladaapp/pages/user_app/user/faq_page.dart';
import 'package:coladaapp/pages/user_app/user/notfifcations_page.dart';
import 'package:coladaapp/pages/user_app/user/profile_page.dart';
import 'package:coladaapp/pages/user_app/user/uesr_location_page.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: [
  AutoRoute(
    initial: true,
    path: '/',
    name: 'SplashRoute',
    page: SplashScreen,
  ),
  AutoRoute(
    path: '/login',
    name: 'LoginRoute',
    page: LoginPage,
  ),
  AutoRoute(
    path: 'menu-webview',
    name: 'MenuRoute',
    page: MenuPage,
  ),
  AutoRoute(
    path: '/otp',
    name: 'OtpRoute',
    page: OtpPage,
  ),
  AutoRoute(
    path: '/user-location',
    name: 'UserLocationRoute',
    page: UserLocationPage,
  ),
  AutoRoute(
    path: '/bottom-navigation-page',
    page: BottomNavigationPage,
    children: [
      AutoRoute(
        path: 'home',
        name: 'HomeRoute',
        page: HomePage,
      ),
      AutoRoute(
        path: 'favourite',
        name: 'FavouriteRoute',
        page: FavouritePage,
      ),
      AutoRoute(
        path: 'activity',
        name: 'ActivityRoute',
        page: ActivityPage,
      ),
      AutoRoute(
          path: 'profile',
          name: 'ProfileRoute',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: ProfilePage, name: 'ProfilePageRoute'),
            AutoRoute(
                path: '', page: CashbackHistory, name: 'CashbackHistoryRoute'),
          ]),
    ],
  ),
  AutoRoute(
    path: 'restaurant-details',
    name: 'RestaurantDetailsRoute',
    page: RestaurantDetails,
  ),
  AutoRoute(
    path: 'offer-details',
    name: 'OfferDetailsRoute',
    page: OfferDetails,
  ),
  AutoRoute(
    path: 'qr-scanner',
    name: 'QRScannerRoute',
    page: QRScanner,
  ),
  AutoRoute(
    path: 'qr-camera',
    name: 'QRCameraRoute',
    page: QRCamera,
  ),
  AutoRoute(
    path: 'account-settings',
    name: 'AccountSettingsRoute',
    page: AccountSettingsPage,
  ),
  AutoRoute(
    path: 'map-picker',
    name: 'MapPickerRoute',
    page: MapPickerPage,
  ),
  AutoRoute(
    path: 'map-locator',
    name: 'MapLocator',
    page: MapPage,
  ),
  AutoRoute(
    path: 'Edite-Profil',
    name: 'EditProfileRoute',
    page: EditProfilePage,
  ),
  AutoRoute(
    path: 'Notfifcations-Page',
    name: 'NotfifcationsRoute',
    page: NotificationsPage,
  ),
  AutoRoute(
    path: 'See-All-Restaurant-Page',
    name: 'SeeAllRestaurantRoute',
    page: SeeAllRestaurant,
  ),
  AutoRoute(
    path: 'Filter-Page',
    name: 'FilterRoute',
    page: FilterPage,
  ),
  AutoRoute(
    path: 'On_Boarding_Page',
    name: 'OnBoardingPage',
    page: OnBoardingPage,
  ),
  AutoRoute(
    path: 'QR_Store_OffersPage',
    name: 'QRStoreOffersPage',
    page: QRStoreOffersPage,
  ),
  AutoRoute(
    path: 'Order_Details_Page',
    name: 'OrderDetailsPageRoute',
    page: OrderDetailsPage,
  ),
  AutoRoute(
    path: 'AllStorePage',
    name: 'AllStorePageRoute',
    page: AllStorePage,
  ),
  AutoRoute(
    path: 'AllFueatureStorePage',
    name: 'AllFueatureStorePageRoute',
    page: AllFueatureStorePage,
  ),
  AutoRoute(
    path: 'SignUp_New_User_Page',
    name: 'SignUpNewUserPageRoute',
    page: SignUpNewUserPage,
  ),
  AutoRoute(
    path: 'Fag_Page',
    name: 'FagPageRoute',
    page: FagPage,
  ),
])
class $AppRouter {}
