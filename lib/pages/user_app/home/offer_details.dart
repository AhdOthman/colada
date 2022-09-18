import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:coladaapp/generated/locale_keys.g.dart';
import 'package:coladaapp/models/offers/offers_model.dart';
import 'package:coladaapp/models/stores/store_model.dart';
import 'package:coladaapp/pages/user_app/home/offer_details_item.dart';
import 'package:coladaapp/provider/offers/offers_provider.dart';
import 'package:coladaapp/provider/stores/stores_provider.dart';
import 'package:coladaapp/routes/routes.gr.dart';
import 'package:coladaapp/utils/constants/constants.dart';
import 'package:coladaapp/utils/failure.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:coladaapp/widgets/app_bar_widget.dart';
import 'package:coladaapp/widgets/button_widget.dart';
import 'package:coladaapp/widgets/loader_widget.dart';
import 'package:coladaapp/widgets/network_image_widget.dart';
import 'package:coladaapp/widgets/text_widget.dart';
import 'package:coladaapp/widgets/title_widget.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OfferDetails extends ConsumerStatefulWidget {
  final OffersModel offersList;

  const OfferDetails({Key? key, required this.offersList}) : super(key: key);

  @override
  ConsumerState<OfferDetails> createState() => _OfferDetailsState();
}

class _OfferDetailsState extends ConsumerState<OfferDetails> {
  late final StoreModel? storeModel;

  late Future _fetchGetStoreOffersFuture;
  @override
  void initState() {
    storeModel = ref.read(storeProvider).storeModel;
    _fetchGetStoreOffersFuture = _fetchStoreOffers();

    super.initState();
  }

  bool isCurrentVisitLoading = true;

  Future _fetchStoreOffers() async {
    final offersProv = ref.read(offersProvider);
    return await offersProv.getOffersDetails(widget.offersList.id!);
  }

  final openNowProv = StateProvider.autoDispose<bool>((ref) => false);

  @override
  Widget build(BuildContext context) {
    var date = widget.offersList.timings ?? [];
    print(widget.offersList.id);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppBarWidget(
        backColor: Colors.white,
      ),
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.zero,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: '1234',
                  child: NetworkImageWidget(
                    widget.offersList.photo ??
                        'https://g5g5new.s3.eu-west-2.amazonaws.com/2021/06/131391081_842368429665957_5677427331423131691_n.jpg',
                    height: 285,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(
                  height: Constants.padding / 2,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Constants.padding),
                  child: TextWidget(
                    storeModel!.name ?? "Store Name",
                    color: AppColors.gray,
                  ),
                ),
                const SizedBox(
                  height: Constants.padding / 2,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Constants.padding),
                  child: TitleWidget(widget.offersList.name ?? "Offer Name"),
                ),
                const SizedBox(
                  height: Constants.padding / 2,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Constants.padding),
                  child: TitleWidget(widget.offersList.details?.en ?? "",
                      //  fontSize: 16,
                      //  color: color,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      fontFamily: 'SfPro'),
                ),
                const SizedBox(
                  height: Constants.padding / 2,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: Constants.padding),
                  child: Divider(),
                ),
                const SizedBox(
                  height: Constants.padding / 2,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Constants.padding),
                  child: TitleWidget(LocaleKeys.term_and_condition.tr(),
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      fontFamily: 'SfPro'),
                ),
                const SizedBox(
                  height: Constants.padding / 2,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Constants.padding),
                  child: TitleWidget(
                      LocaleKeys.term_and_conditions_description.tr(),
                      //  fontSize: 16,
                      //  color: color,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      fontFamily: 'SfPro'),
                ),
                const SizedBox(
                  height: Constants.padding / 2,
                ),
                ListTile(
                  dense: true,
                  leading: SvgPicture.asset(
                    'assets/icons/location_icon.svg',
                    color: AppColors.black,
                  ),
                  title: Transform.translate(
                    offset: const Offset(-25, -2),
                    child: Row(
                      children: [
                        TextWidget(
                          '${LocaleKeys.branch_title.tr()}: ',
                          color: AppColors.gray,
                        ),
                        Expanded(
                          child: Text(
                            ref.read(storeProvider).getLocation ?? "Not found",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'SfPro',
                                fontWeight: FontWeight.w400,
                                color: AppColors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                date.isNotEmpty
                    ? Transform.translate(
                        offset: const Offset(3, -5),
                        child: ListTile(
                          dense: true,
                          leading: SvgPicture.asset(
                            'assets/icons/clock_icon.svg',
                            color: AppColors.black,
                          ),
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
                      )
                    : Container(),
                if (ref.watch(openNowProv.state).state)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Constants.padding * 2),
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Text(widget
                                  .offersList.timings![index].startingTime
                                  .toString()),
                              const SizedBox(
                                width: Constants.padding,
                              ),
                              const TextWidget("to"),
                              const SizedBox(
                                width: Constants.padding,
                              ),
                              Text(widget.offersList.timings![index].endingTime
                                  .toString()),
                              const SizedBox(
                                width: Constants.padding,
                              ),
                              const SizedBox(
                                width: Constants.padding,
                              ),
                              Text(widget.offersList.timings![index].weekDay
                                  .toString()),
                            ],
                          );
                        },
                        itemCount: date.length),
                  ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: Constants.padding),
                  child: Divider(),
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
                            ref.watch(offersProvider).getOfferItemList ?? [];
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
                              child: OffersDetailsItem(
                                offersModel: offersList[index],
                              ),
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: Constants.padding,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Constants.padding,
                ),
                child: ButtonWidget(
                  title: 'GET OFFER',
                  onPressed: () {
                    context.router.push(const QRScannerRoute());
                  },
                  textColor: AppColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
