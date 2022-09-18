import 'package:coladaapp/generated/locale_keys.g.dart';
import 'package:coladaapp/provider/user/user_provider.dart';
import 'package:coladaapp/provider/visit/visit_provider.dart';
import 'package:coladaapp/utils/constants/constants.dart';
import 'package:coladaapp/utils/failure.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:coladaapp/widgets/app_bar_widget.dart';
import 'package:coladaapp/widgets/loader_widget.dart';
import 'package:coladaapp/widgets/text_widget.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'visit_restaurant.dart';

class ActivityPage extends ConsumerStatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends ConsumerState<ActivityPage> {
  late Future _getUserVisitsFuture;
  final number = "+966592105548";
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _getUserVisitsFuture = _fetchGetFeaturedUserVisit();

    _scrollController.addListener(() {
      final visitProv = ref.watch(visitProvider);

      if (visitProv.userVisits!.pagination!.hasNextPage == true) {
        final userProv = ref.read(userProvider);
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          visitProv.getUserVisits(
            customerId: userProv.user!.id!,
            perPage: visitProv.userVisits!.pagination!.perPage,
            page: visitProv.userVisits!.pagination!.nextPage,
          );
        }
      }
    });

    super.initState();
  }

  Future _fetchGetFeaturedUserVisit() async {
    final userProv = ref.read(userProvider);
    final visitProv = ref.read(visitProvider);
    return await visitProv.getUserVisits(customerId: userProv.user!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([_getUserVisitsFuture]),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return const Center(child: TextWidget('Something Wrong'));
        } else if (snapshot.hasData) {
          if (snapshot.data is Failure) {
            return Center(child: TextWidget(snapshot.data.toString()));
          }

          return Scaffold(
            appBar: AppBarWidget(
              title: LocaleKeys.visit_history_title.tr(),
              actions: [
                GestureDetector(
                  onTap: () async {
                    await launch("https://wa.me/${number}");
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: context.locale.toString() == "en" ? 20.0 : 0,
                        left: context.locale.toString() == "ar" ? 20.0 : 0),
                    child: SvgPicture.asset(
                      'assets/svg/ic_help.svg',
                      width: 25,
                      height: 25,
                    ),
                  ),
                ),
              ],
              automaticallyImplyLeading: false,
            ),
            body: RefreshIndicator(
              color: AppColors.primaryColor,

              onRefresh: () async {
                final visitProv = ref.read(visitProvider);
                final userProv = ref.read(userProvider);

                visitProv.clearVisits();
                ref.watch(visitProvider).getUserVisits(
                      customerId: userProv.user!.id!,
                      perPage: 3,
                      page: 1,
                    );
              },
              // sowh dilaog

              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    final userVisitsList =
                        ref.watch(visitProvider).userVisits!.visits ?? [];
                    return userVisitsList.isNotEmpty
                        ? ListView.builder(
                            controller: _scrollController,
                            shrinkWrap: true,
                            //     primary: false,
                            itemCount: userVisitsList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(
                                  Constants.padding,
                                ),
                                child: VisitRestaurant(
                                  isHomePage: false,
                                  userVisits: userVisitsList[index],
                                ),
                              );
                            },
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: const Center(
                                child: TextWidget(
                              "unfortunately, There is no data available yet",
                              color: AppColors.gray,
                            )),
                          );
                  },
                ),
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoaderWidget();
        }
        return const LoaderWidget();
      },
    );
  }
}
