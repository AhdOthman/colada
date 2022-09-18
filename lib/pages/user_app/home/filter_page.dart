import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:coladaapp/generated/locale_keys.g.dart';
import 'package:coladaapp/models/stores/filtter_data.dart';
import 'package:coladaapp/models/stores/filtter_data.dart';
import 'package:coladaapp/provider/stores/stores_provider.dart';
import 'package:coladaapp/routes/routes.gr.dart';
import 'package:coladaapp/utils/constants/constants.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:coladaapp/utils/ui_helper.dart';
import 'package:coladaapp/widgets/app_bar_widget.dart';
import 'package:coladaapp/widgets/button_widget.dart';
import 'package:coladaapp/widgets/text_widget.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class FilterPage extends ConsumerStatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends ConsumerState<FilterPage> {
  List<FiltterDate> categories = [];
  List<FiltterDate> cuisines = [];
  List<FiltterDate> timing = [];
  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    categories = categoriesData;
    timing = timingData;
    cuisines = cuisinesData;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Filter Settings',
      ),
      body: Padding(
        padding: const EdgeInsets.all(Constants.padding),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(LocaleKeys.catagories_title.tr()),
                GestureDetector(
                    onTap: () {
                      ref
                          .watch(storeProvider)
                          .changeCategoriesData(0, clear: true);
                    },
                    child: Text(LocaleKeys.clear_all_title.tr())),
              ],
            ),
            const SizedBox(height: Constants.padding),
            Consumer(
              builder: (context, ref, child) {
                return GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                  ),
                  itemBuilder: (_, index) => categoriesItem(
                      index: index,
                      ref: ref,
                      isSelected: categories[index].isSelected,
                      title: categories[index].title,
                      svgPath: categories[index].svgPath),
                  itemCount: categories.length,
                );
              },
            ),
            const SizedBox(height: Constants.padding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(LocaleKeys.timings_title.tr()),
                GestureDetector(
                    onTap: () {
                      ref.watch(storeProvider).changeTimingData(0, clear: true);
                    },
                    child: Text(LocaleKeys.clear_all_title.tr())),
              ],
            ),
            const SizedBox(height: Constants.padding),
            GridView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              ),
              itemBuilder: (_, index) => timingItem(timingData[index], index),
              itemCount: timing.length,
            ),
            const SizedBox(height: Constants.padding * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(LocaleKeys.cuisine_title.tr()),
                GestureDetector(
                    onTap: () {
                      ref
                          .watch(storeProvider)
                          .changeCuisinesData(0, clear: true);
                    },
                    child: Text(LocaleKeys.clear_all_title.tr())),
              ],
            ),
            const SizedBox(height: Constants.padding),
            GridView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.0,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              ),
              itemBuilder: (_, index) =>
                  cuisinesItem(cuisinesData[index], index),
              itemCount: cuisines.length,
            ),
            const SizedBox(height: Constants.padding),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Constants.padding,
              ),
              child: ButtonWidget(
                title: LocaleKeys.apply_filter_types.tr(),
                onPressed: () {
                  var selectedCategories =
                      ref.watch(storeProvider).getSelectedCategories();
                  print("selectedCategories: $selectedCategories");
                  var selectedcuisines =
                      ref.watch(storeProvider).getSelectedCuisines();
                  print("selectedcuisines: $selectedcuisines");
                  var selectedWorkingHours =
                      ref.watch(storeProvider).getSelectedTiming();
                  print("selectedWorkingHours: $selectedWorkingHours");

                  if (selectedCategories.isEmpty) {
                    UIHelper.showNotification(
                        "You must choose at least one category");
                  } else if (selectedcuisines.isEmpty) {
                    UIHelper.showNotification(
                        "You must choose at least one cuisine");
                  } else if (selectedWorkingHours.isEmpty) {
                    UIHelper.showNotification(
                        "You must choose at least one working Hours");
                  } else {
                    ref
                        .watch(storeProvider)
                        .getFiltterStores(
                          categories: selectedCategories,
                          cuisines: selectedcuisines,
                          workingHours: selectedWorkingHours,
                        )
                        .then((value) =>
                            context.router.push(const AllStorePageRoute()));
                  }
                },
                textColor: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoriesItem(
      {required String title,
      String? svgPath,
      required int index,
      required bool isSelected,
      required WidgetRef ref}) {
    return GestureDetector(
      onTap: () {
        ref.watch(storeProvider).changeCategoriesData(index);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : AppColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.primaryColor, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (svgPath != null) SvgPicture.asset(svgPath),
            const SizedBox(height: 8),
            TextWidget(
              title,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }

  Widget cuisinesItem(FiltterDate filtterDate, int index) {
    return GestureDetector(
      onTap: () {
        ref.watch(storeProvider).changeCuisinesData(index);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: filtterDate.isSelected
              ? AppColors.primaryColor
              : AppColors.simeGray,
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Center(
            child: TextWidget(
          filtterDate.title,
          fontWeight: FontWeight.w500,
        )),
      ),
    );
  }

  Widget timingItem(FiltterDate filtterDate, int index) {
    return GestureDetector(
      onTap: () {
        ref.watch(storeProvider).changeTimingData(index);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: filtterDate.isSelected
              ? AppColors.primaryColor
              : AppColors.simeGray,
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Center(
            child: TextWidget(
          "${filtterDate.title}(${filtterDate.startTime}-${filtterDate.endTime})",
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}
