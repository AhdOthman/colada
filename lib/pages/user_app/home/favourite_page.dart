import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:coladaapp/generated/locale_keys.g.dart';
import 'package:coladaapp/provider/stores/stores_provider.dart';
import 'package:coladaapp/provider/user/user_provider.dart';
import 'package:coladaapp/routes/routes.gr.dart';
import 'package:coladaapp/utils/failure.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:coladaapp/widgets/app_bar_widget.dart';
import 'package:coladaapp/widgets/loader_widget.dart';
import 'package:coladaapp/widgets/text_widget.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'restaurants.dart';

class FavouritePage extends ConsumerStatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends ConsumerState<FavouritePage> {
  late Future _getFavoriteStoresFuture;

  @override
  void initState() {
    _getFavoriteStoresFuture = _getFavoriteStores();

    _scrollController.addListener(() {
      final storeProv = ref.watch(storeProvider);
      final userProv = ref.read(userProvider);
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (storeProv.favoriteStores.pagination!.hasNextPage == true) {
          ref.watch(storeProvider).getFavoriteStores(
                customerId: userProv.user!.id!,
                perPage: storeProv.favoriteStores.pagination!.perPage,
                page: storeProv.favoriteStores.pagination!.nextPage,
              );
        }
      }
    });

    super.initState();
  }

  Future _getFavoriteStores() async {
    final storeProv = ref.read(storeProvider);
    final userProv = ref.read(userProvider);

    return await storeProv.getFavoriteStores(customerId: userProv.user!.id!);
  }

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: LocaleKeys.favorites_title.tr(),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
          future: _getFavoriteStoresFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: TextWidget('Something Wrong'));
            } else if (snapshot.hasData) {
              if (snapshot.data is Failure) {
                return Center(child: TextWidget(snapshot.data.toString()));
              }
              return RefreshIndicator(
                color: AppColors.primaryColor,
                onRefresh: () async {
                  final storeProv = ref.read(storeProvider);
                  final userProv = ref.read(userProvider);

                  storeProv.clearFavoriteStores();
                  ref.watch(storeProvider).getFavoriteStores(
                        customerId: userProv.user!.id!,
                        perPage: 3,
                        page: 1,
                      );
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Consumer(
                    builder: (context, ref, child) {
                      final favoriteStores =
                          ref.watch(storeProvider).favoriteStores.stores;
                      return ref
                              .watch(storeProvider)
                              .featuredStores!
                              .stores!
                              .isNotEmpty
                          ? favoriteStores!.isNotEmpty
                              ? SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: ListView.builder(
                                    controller: _scrollController,
                                    itemCount: favoriteStores.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                      onTap: () {
                                        ref.watch(storeProvider).storeModel =
                                            favoriteStores[index];
                                        context.router.push(
                                            const RestaurantDetailsRoute());
                                      },
                                      child: Restaurants(
                                        photos: favoriteStores[index].photos!,
                                        rating: favoriteStores[index].rating!,
                                        name: favoriteStores[index].name!,
                                        cuisines:
                                            favoriteStores[index].cuisines!,
                                        distance:
                                            favoriteStores[index].distance ?? 0,
                                        coladaRate:
                                            favoriteStores[index].coladaRate!,
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  child: const Center(
                                      child: TextWidget(
                                    "unfortunately, There is no data available yet",
                                    color: AppColors.gray,
                                  )),
                                )
                          : const LoaderWidget();
                    },
                  ),
                ),
              );
            }
            return const LoaderWidget();
          }),
    );
  }
}
