import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:coladaapp/pages/user_app/home/restaurants.dart';
import 'package:coladaapp/provider/stores/stores_provider.dart';
import 'package:coladaapp/provider/user/user_provider.dart';
import 'package:coladaapp/routes/routes.gr.dart';
import 'package:coladaapp/utils/constants/constants.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:coladaapp/widgets/app_bar_widget.dart';
import 'package:coladaapp/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchProvider = StateProvider.autoDispose<bool>((ref) => false);

class AllFueatureStorePage extends ConsumerStatefulWidget {
  const AllFueatureStorePage({Key? key}) : super(key: key);

  @override
  _AllStoreState createState() => _AllStoreState();
}

class _AllStoreState extends ConsumerState<AllFueatureStorePage> {
  ScrollController _scrollController = ScrollController();

  var searchController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _scrollController.addListener(() {
        final storeProv = ref.read(storeProvider);

        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          if (storeProv.featuredStores!.pagination!.hasNextPage == true) {
            final userProv = ref.read(userProvider);

            ref.watch(storeProvider).getStores(userProv.user!.location!,
                perPage: storeProv.featuredStores!.pagination!.perPage,
                page: storeProv.featuredStores!.pagination!.nextPage,
                isFeatured: true);
          }
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(
        title: "Feature Store",
        actions: [
          Consumer(
            builder: (context, ref, child) => Padding(
              padding: EdgeInsets.symmetric(horizontal: Constants.padding),
              child: IconButton(
                onPressed: () {
                  ref.watch(searchProvider.state).state =
                      !ref.watch(searchProvider.state).state;
                },
                icon: Icon(Icons.search),
                color: AppColors.black,
              ),
            ),
          )
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          var restaurants = ref.watch(storeProvider).searchedStores == null
              ? ref.watch(storeProvider).featuredStores!.stores ?? []
              : ref.watch(storeProvider).searchedStores ?? [];
          return RefreshIndicator(
            color: AppColors.primaryColor,
            onRefresh: () async {
              final storeProv = ref.read(storeProvider);
              final userProv = ref.read(userProvider);

              storeProv.clearFeatured();
              ref.watch(storeProvider).getStores(userProv.user!.location!,
                  perPage: 3, page: 1, isFeatured: true);
            },
            child: ref.watch(storeProvider).featuredStores!.stores!.length != 0
                ? Column(
                    children: [
                      Center(
                        child: ref.watch(searchProvider.state).state
                            ? Container(
                                width: size.width * 0.8,
                                height: size.height * 0.06,
                                decoration: BoxDecoration(
                                  color: AppColors.simeGray,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextField(
                                  controller: searchController,
                                  autocorrect: true,
                                  onSubmitted: (value) {
                                    ref
                                        .watch(storeProvider)
                                        .getSearchedStores(value);
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintText: 'Store name',
                                    contentPadding: const EdgeInsets.only(
                                        left: 15,
                                        bottom: 10,
                                        top: 13,
                                        right: 15),
                                    prefixIcon: IconButton(
                                      icon: const Icon(
                                        Icons.search,
                                        color: AppColors.gray,
                                      ),
                                      onPressed: () {
                                        print(searchController.text);
                                        ref
                                            .watch(storeProvider)
                                            .getSearchedStores(
                                                searchController.text);
                                      },
                                    ),
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () {
                                        restaurants = ref
                                                .watch(storeProvider)
                                                .featuredStores
                                                ?.stores ??
                                            [];
                                        ref
                                            .watch(storeProvider)
                                            .cleanSearchedStores();
                                        print(
                                            "ref.watch(storeProvider).favoriteStores ${ref.watch(storeProvider).featuredStores?.stores!.length}");
                                        ref.watch(searchProvider.state).state =
                                            !ref
                                                .watch(searchProvider.state)
                                                .state;
                                      },
                                      color: AppColors.gray,
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ),
                      Expanded(
                        child: ListView(
                          controller: _scrollController,
                          children: [
                            ListView.builder(
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
                                      distance: 555,
                                      cuisines: restaurants[index].cuisines!,
                                      photos: restaurants[index].photos!,
                                      coladaRate:
                                          restaurants[index].coladaRate!,
                                      rating: restaurants[index].rating!,
                                    ));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : const LoaderWidget(),
          );
        },
      ),
    );
  }
}
