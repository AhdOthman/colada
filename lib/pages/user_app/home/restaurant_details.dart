import 'dart:convert';

import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:coladaapp/generated/locale_keys.g.dart';
import 'package:coladaapp/models/stores/store_model.dart';
import 'package:coladaapp/models/user/user_model.dart';
import 'package:coladaapp/provider/offers/offers_provider.dart';
import 'package:coladaapp/provider/stores/stores_provider.dart';
import 'package:coladaapp/provider/user/user_provider.dart';
import 'package:coladaapp/routes/routes.gr.dart';
import 'package:coladaapp/utils/constants/constants.dart';
import 'package:coladaapp/utils/failure.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:coladaapp/widgets/app_bar_widget.dart';
import 'package:coladaapp/widgets/loader_widget.dart';
import 'package:coladaapp/widgets/network_image_widget.dart';
import 'package:coladaapp/widgets/slider_widget.dart';
import 'package:coladaapp/widgets/subtitle_widget.dart';
import 'package:coladaapp/widgets/text_widget.dart';
import 'package:coladaapp/widgets/title_widget.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'offers.dart';
import 'package:geocoding/geocoding.dart';

class RestaurantDetails extends ConsumerStatefulWidget {
  const RestaurantDetails({Key? key}) : super(key: key);

  @override
  _RestaurantDetailsState createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends ConsumerState<RestaurantDetails> {
  bool init = true;
  StoreModel storeData = StoreModel();
  String location = "";
  bool isFavorite = false;
  @override
  void didChangeDependencies() {
    if (init) {
      storeData = ref.read(storeProvider).storeModel;
      isFavorite = ref.read(storeProvider).storeModel.isSeclected;
      ref.read(userProvider).user!.favorites?.forEach((element) {
        if (element == storeData.id) {
          ref.watch(storeProvider).storeModel.isSeclected = true;
        }
      });
      print("menuurl: ${storeData.menu}");

      init = false;
    }
    super.didChangeDependencies();
  }

  late Future _fetchGetStoreOffersFuture;
  bool isCurrentVisitLoading = true;

  @override
  void initState() {
    _fetchGetStoreOffersFuture = _fetchStoreOffers();
    getAddressFromLatLng().then((value) {
      if (value != null) {
        ref.watch(storeProvider).setNewLocation(value);
      } else {
        location = "addres not found";
      }
    });
    super.initState();
  }

  Future _fetchStoreOffers() async {
    final offersProv = ref.read(offersProvider);
    return await offersProv
        .getStoresOffers(ref.read(storeProvider).storeModel.id!);
  }

  Future getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(30.1233846, 31.252174);
      print(placemarks.first);
      return "${placemarks.first.street}, ${placemarks.first.subLocality}, ${placemarks.first.locality}, ${placemarks.first.country}";
    } catch (e) {
      location = "no date";
      print(e);
      return null;
    }
  }

  final openNowProv = StateProvider.autoDispose<bool>((ref) => false);
  @override
  Widget build(BuildContext context) {
    print(ref.watch(storeProvider).storeModel.isSeclected);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppBarWidget(
        backColor: Colors.white,
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: '1234',
                child: SliderWidget(
                  height: size.height * 0.28,
                  photos: storeData.photos ?? [],
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: Constants.padding),
                child: TitleWidget(storeData.name!),
              ),
              const SizedBox(
                height: Constants.padding / 2,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: Constants.padding),
                child: TextWidget(
                  storeData.cuisines!.join(' . '),
                  color: AppColors.gray,
                ),
              ),
              const SizedBox(
                height: Constants.padding / 2,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: Constants.padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SubtitleWidget(storeData.coladaRate!.toString()),
                        const SizedBox(
                          width: Constants.padding,
                        ),
                        SvgPicture.asset('assets/icons/star_icon.svg'),
                        SubtitleWidget(storeData.rating.toString()),
                      ],
                    ),
                    Consumer(
                      builder: (BuildContext context, WidgetRef ref,
                              Widget? child) =>
                          IconButton(
                        onPressed: () {
                          if (!ref
                              .watch(storeProvider)
                              .storeModel
                              .isSeclected) {
                            ref.watch(storeProvider).storeModel.isSeclected =
                                !ref
                                    .watch(storeProvider)
                                    .storeModel
                                    .isSeclected;
                            ref
                                .read(storeProvider)
                                .addFavoriteStores(
                                    customerId:
                                        ref.watch(userProvider).user!.id!,
                                    storeId: storeData.id)
                                .then((value) {
                              if (value is! Failure) {
                                ref
                                    .watch(userProvider)
                                    .setUser(UserModel.fromJson(value));
                                ref
                                    .watch(storeProvider)
                                    .favoriteStores
                                    .stores!
                                    .add(storeData);
                              }
                            });
                          } else {
                            ref.watch(storeProvider).storeModel.isSeclected =
                                !ref
                                    .watch(storeProvider)
                                    .storeModel
                                    .isSeclected;
                            ref
                                .read(storeProvider)
                                .removeFavoriteStores(
                                    customerId:
                                        ref.watch(userProvider).user!.id!,
                                    storeId: storeData.id)
                                .then((value) {
                              if (value is! Failure) {
                                ref
                                    .watch(userProvider)
                                    .setUser(UserModel.fromJson(value));

                                ref
                                    .watch(storeProvider)
                                    .favoriteStores
                                    .stores!
                                    .removeWhere((element) =>
                                        element.id == storeData.id);
                              }
                            });
                          }
                          print(
                              ref.watch(storeProvider).storeModel.isSeclected);
                        },
                        icon: Icon(
                          ref.watch(storeProvider).storeModel.isSeclected
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: AppColors.red,
                          size: Constants.padding * 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: Constants.padding / 2,
              ),
              GestureDetector(
                  onTap: () {
                    context.router
                        .push(MenuRoute(webViewUrl: storeData.menu ?? ""));
                  },
                  child: Center(child: Image.asset('assets/images/menu.png'))),
              Center(
                child: CupertinoButton(
                    child: const TextWidget('see full menu',
                        color: AppColors.lightBlue),
                    onPressed: () {
                      context.router
                          .push(MenuRoute(webViewUrl: storeData.menu ?? ""));
                    }),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Constants.padding),
                child: Divider(),
              ),

              Consumer(
                  builder: (context, ref, child) => ListTile(
                        dense: true,
                        leading:
                            SvgPicture.asset('assets/icons/location_icon.svg'),
                        title: GestureDetector(
                          onTap: () => context.router.push(MapLocator(
                              lat: storeData.location!.lat ?? 0,
                              long: storeData.location!.lng ?? 0)),
                          child: TextWidget(
                            ref.read(storeProvider).getLocation ?? "not found",
                            color: AppColors.lightBlue,
                          ),
                        ),
                      )),

              Consumer(
                builder: (context, ref, child) => ListTile(
                  dense: true,
                  leading: SvgPicture.asset('assets/icons/clock_icon.svg'),
                  onTap: () {
                    print(ref.watch(openNowProv.state).state);
                    ref.watch(openNowProv.state).state =
                        !ref.read(openNowProv.state).state;
                    print(ref.read(openNowProv.state).state);
                  },
                  title: Row(
                    children: [
                      TextWidget(
                        LocaleKeys.open_status.tr(),
                        color: AppColors.green,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Constants.padding),
                        child: !ref.watch(openNowProv.state).state
                            ? const Icon(Icons.keyboard_arrow_down)
                            : const Icon(Icons.keyboard_arrow_up),
                      ),
                    ],
                  ),
                ),
              ),

              Consumer(builder: (context, ref, child) {
                final isCorrect = ref.watch(openNowProv.state).state;
                final data = ref.read(storeProvider).storeModel;
                print("data is ${data.workingHours!.length}");
                return isCorrect
                    ? ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          print("data is ${data.workingHours![index].weekday}");

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Constants.padding),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: Constants.padding,
                                ),
                                Text(data.workingHours![index].weekday
                                    .toString()),
                                const SizedBox(
                                  width: Constants.padding,
                                ),
                                Text(data.workingHours![index].openingTime
                                    .toString()),
                                const SizedBox(
                                  width: Constants.padding,
                                ),
                                Text(data.workingHours![index].closingTime
                                    .toString()),
                                const SizedBox(
                                  width: Constants.padding,
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: data.workingHours!.length)
                    : Container();
              }),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Constants.padding),
                child: Divider(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: Constants.padding),
                child: TitleWidget(LocaleKeys.offers_text.tr()),
              ),
              Consumer(
                builder: (context, ref, child) => FutureBuilder(
                  future: _fetchGetStoreOffersFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: LoaderWidget(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }
                    if (snapshot.hasData) {
                      final offersList =
                          ref.watch(offersProvider).getOffersList ?? [];
                      if (snapshot.data is Failure) {
                        return Center(
                            child: Column(
                          children: const [
                            SizedBox(
                              height: Constants.padding * 2,
                            ),
                            TextWidget(
                              "unfortunately, There is no data available yet",
                            ),
                          ],
                        ));
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        //     primary: false,
                        padding: EdgeInsets.zero,
                        itemCount: offersList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Constants.padding,
                                vertical: Constants.padding),
                            child: GestureDetector(
                              onTap: () {
                                context.router.push(OfferDetailsRoute(
                                    offersList: offersList[index]));
                              },
                              child: Offers(
                                offersModel: offersList[index],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Container();
                  },
                ),
              ),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: Constants.padding),
              //   child: Offers(),
              // ),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: Constants.padding),
              //   child: Offers(),
              // ),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: Constants.padding),
              //   child: Offers(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
