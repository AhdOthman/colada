import 'package:coladaapp/generated/locale_keys.g.dart';
import 'package:coladaapp/models/user/user_location_model.dart';
import 'package:coladaapp/pages/user_app/home/all_feature_store_page.dart';
import 'package:coladaapp/provider/offers/offers_provider.dart';
import 'package:coladaapp/provider/stores/stores_provider.dart';
import 'package:coladaapp/provider/user/user_provider.dart';
import 'package:coladaapp/provider/visit/visit_provider.dart';
import 'package:coladaapp/routes/routes.gr.dart';
import 'package:coladaapp/utils/constants/constants.dart';
import 'package:coladaapp/utils/failure.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:coladaapp/utils/ui_helper.dart';
import 'package:coladaapp/widgets/app_bar_widget.dart';
import 'package:coladaapp/widgets/loader_widget.dart';
import 'package:coladaapp/widgets/loading_dialog.dart';
import 'package:coladaapp/widgets/subtitle_widget.dart';
import 'package:coladaapp/widgets/text_widget.dart';
import 'package:coladaapp/widgets/title_widget.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:auto_route/auto_route.dart';

import 'featured_partners.dart';
import 'restaurants.dart';
import 'visit_restaurant.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late Future _getUserFuture;
  late Future _getFeaturedStoreFuture;
  late Future _getRestaurantsFuture;
  late Future _fetchGetCurrentVisitFuture;
  late Future _fetchGetCActiveOffersFuture;
  late Future _fetchGetGenerateReferralCodeFuture;

  bool isCurrentVisitLoading = true;

  @override
  void initState() {
    _getUserFuture = _fetchGetUser();
    _getFeaturedStoreFuture = _fetchGetFeaturedStores();
    _getRestaurantsFuture = _fetchGetRestaurants();
    _fetchGetCurrentVisitFuture = _fetchGetCurrentVisit();
    _fetchGetCActiveOffersFuture = _fetchActiveOffers();
    _fetchGetGenerateReferralCodeFuture = _fetchGetGenerateReferralCode();
    // _getUserVisitsFuture = _fetchGetFeaturedUserVisit();
    super.initState();
  }

  // Future _fetchGetFeaturedUserVisit() async {
  //   final userProv = ref.read(userProvider);
  //   final visitProv = ref.read(visitProvider);
  //   return await visitProv.getUserVisits(userProv.user!.id!);
  // }

  Future _updateUserLocation(UserLocationModel location) async {
    try {
      final userProv = ref.read(userProvider);
      loadingDialog(context);
      await userProv.updateUser(userProv.user!.id!, location);
      Navigator.pop(context);
    } on Failure {
      debugPrint('error update user');
      Navigator.pop(context);
    }
  }

  Future _fetchGetUser() async {
    final userProv = ref.read(userProvider);
    return await userProv.getUser(userProv.user!.id!);
  }

  Future _fetchGetGenerateReferralCode() async {
    final userProv = ref.read(userProvider);
    return await userProv.getGenerateReferralCode(userProv.user!.id!);
  }

  Future _fetchActiveOffers() async {
    final offersProv = ref.read(offersProvider);
    return await offersProv.getActiveOffers();
  }

  Future _fetchGetFeaturedStores() async {
    final userProv = ref.read(userProvider);
    final storeProv = ref.read(storeProvider);
    return await storeProv.getStores(userProv.user!.location!);
  }

  Future _fetchGetCurrentVisit() async {
    final userProv = ref.read(userProvider);
    final visitProv = ref.read(visitProvider);
    print("userProv ${userProv.user!.location}");
    print("userProv ${userProv.user!.id}");
    return await visitProv.getCurrentVisit(userProv.user!.id!);
  }

  Future _fetchGetRestaurants() async {
    final userProv = ref.read(userProvider);
    final storeProv = ref.read(storeProvider);
    return await storeProv.getStores(userProv.user!.location!,
        isFeatured: false);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        _fetchGetGenerateReferralCodeFuture,
        _getFeaturedStoreFuture,
        _getUserFuture,
        _getRestaurantsFuture,
        _fetchGetCurrentVisitFuture,
        _fetchGetCActiveOffersFuture,
      ]),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return const Center(child: TextWidget('Something Wrong'));
        } else if (snapshot.hasData) {
          if (snapshot.data is Failure) {
            return Center(child: TextWidget(snapshot.data.toString()));
          }
          return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              appBar: AppBarWidget(
                automaticallyImplyLeading: false,
                centerTitle: false,
                titleWidget: GestureDetector(
                  onTap: () async {
                    try {
                      List location =
                          await context.router.push(const MapPickerRoute())
                              as List<UserLocationModel>;
                      _updateUserLocation(location.first);
                    } catch (e) {
                      // user didn't pick a location
                      // UIHelper.showNotification('Can not pick the location');
                    }
                  },
                  child: ListTile(
                    title: SubtitleWidget(LocaleKeys.location_title.tr(),
                        textAlign: TextAlign.start),
                    subtitle: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Consumer(builder: (context, ref, child) {
                          final userLocation =
                              ref.watch(userProvider).user!.location;
                          return TitleWidget(userLocation!.city ?? '');
                        }),
                        SvgPicture.asset('assets/icons/arrow_down_icon.svg'),
                      ],
                    ),
                  ),
                ),
                actions: [
                  CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: SvgPicture.asset(
                        'assets/icons/notification_icon.svg',
                      ),
                      onPressed: () {
                        context.router.push(const NotfifcationsRoute());
                      }),
                  CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: SvgPicture.asset('assets/icons/filter_icon.svg'),
                      onPressed: () {
                        context.router.push(const FilterRoute());
                      }),
                ],
              ),
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer(builder:
                          (BuildContext context, WidgetRef ref, Widget? child) {
                        isCurrentVisitLoading =
                            ref.watch(visitProvider).getCurrentVisits == null
                                ? false
                                : true;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            isCurrentVisitLoading
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Constants.padding,
                                        vertical: Constants.padding),
                                    child: TextWidget(
                                        LocaleKeys.current_visit_title.tr()),
                                  )
                                : Container(),
                            isCurrentVisitLoading
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Constants.padding),
                                    child: VisitRestaurant(
                                      isHomePage: true,
                                      currentVisits: ref
                                          .watch(visitProvider)
                                          .getCurrentVisits![0],
                                    ))
                                : Container()
                          ],
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Constants.padding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(LocaleKeys.featured_partners_title.tr()),
                            CupertinoButton(
                              onPressed: () {
                                ref.watch(storeProvider).cleanSearchedStores();
                                context.router
                                    .push(const AllFueatureStorePageRoute());
                              },
                              child: TextWidget(
                                LocaleKeys.see_all_title.tr(),
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 300,
                        child: Consumer(
                          builder: (BuildContext context, WidgetRef ref,
                              Widget? child) {
                            final featuredStores = ref
                                    .watch(storeProvider)
                                    .featuredStores!
                                    .stores ??
                                [];
                            return ListView.builder(
                              itemCount: featuredStores.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      ref.watch(storeProvider).storeModel =
                                          featuredStores[index];
                                      //    phoneNumberProvider.state =
                                      //       featuredStores[index];
                                      context.router
                                          .push(const RestaurantDetailsRoute());
                                    },
                                    child: FeaturedPartners(
                                      id: featuredStores[index].id!,
                                      name: featuredStores[index].name!,
                                      distance: featuredStores[index].distance!,
                                      image:
                                          featuredStores[index].photos!.first,
                                      rate: featuredStores[index].rating!,
                                      cuisines: featuredStores[index].cuisines!,
                                    ));
                              },
                              scrollDirection: Axis.horizontal,
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Constants.padding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TextWidget('All Stores'),
                            CupertinoButton(
                              onPressed: () {
                                ref.watch(storeProvider).cleanSearchedStores();
                                context.router.push(const AllStorePageRoute());
                              },
                              child: TextWidget(
                                LocaleKeys.see_all_title.tr(),
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          final restaurants =
                              ref.watch(storeProvider).restaurants.stores ?? [];
                          return ListView.builder(
                            itemCount: restaurants.length,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    ref.watch(storeProvider).storeModel =
                                        restaurants[index];
                                    context.router
                                        .push(const RestaurantDetailsRoute());
                                  },
                                  child: Restaurants(
                                    name: restaurants[index].name!,
                                    distance: restaurants[index].distance!,
                                    cuisines: restaurants[index].cuisines!,
                                    photos: restaurants[index].photos!,
                                    coladaRate: restaurants[index].coladaRate!,
                                    rating: restaurants[index].rating!,
                                  ));
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: Constants.padding,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return const LoaderWidget();
      },
    );
  }
}
