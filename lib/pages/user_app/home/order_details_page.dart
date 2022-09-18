import 'package:coladaapp/generated/locale_keys.g.dart';
import 'package:coladaapp/models/visits/check_out_details.dart';
import 'package:coladaapp/models/visits/user_visits_model.dart';
import 'package:coladaapp/pages/user_app/home/visit_restaurant.dart';
import 'package:coladaapp/provider/qr/qr_provider.dart';
import 'package:coladaapp/provider/visit/visit_provider.dart';
import 'package:coladaapp/utils/constants/constants.dart';
import 'package:coladaapp/utils/failure.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:coladaapp/widgets/app_bar_widget.dart';
import 'package:coladaapp/widgets/button_widget.dart';
import 'package:coladaapp/widgets/loader_widget.dart';
import 'package:coladaapp/widgets/text_widget.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsPage extends ConsumerStatefulWidget {
  final UserVisits? userVisits;

  const OrderDetailsPage({Key? key, this.userVisits}) : super(key: key);

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends ConsumerState<OrderDetailsPage> {
  late Future _fetchGenerateVisitQRFuture;
  late Future _fetchCheckOutFuture;

  @override
  void initState() {
    _fetchGenerateVisitQRFuture = _fetchGenerateVisitQR();
    _fetchCheckOutFuture = _fetchCheckOutDetails();

    super.initState();
  }

  Future _fetchGenerateVisitQR() async {
    final qrProv = ref.read(qrProvider);
    return await qrProv.getGenerateVisitQR(widget.userVisits!.id!);
  }

  Future _fetchCheckOutDetails() async {
    final visitProv = ref.read(visitProvider);
    return await visitProv.postGetCheckOutDetails(
        visitId: widget.userVisits!.id!);
  }

  final number = "+966592105548";
  var commentTextController = TextEditingController();
  var rating = 0.0;
  bool isRated = false;
  @override
  Widget build(BuildContext context) {
    print(context.locale.toString());
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBarWidget(
          title: LocaleKeys.order_details_title.tr(),
          backColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  Center(
                    child: Consumer(
                      builder: (context, ref, child) => FutureBuilder(
                        future: _fetchGenerateVisitQRFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                            if (snapshot.data is Failure) {
                              return Center(
                                  child: TextWidget(snapshot.data.toString()));
                            }
                            final qrProv = ref.watch(qrProvider);
                            print("snapshot data is ${snapshot.data}");

                            print(
                                "qrProv.getGeneratedQR ${qrProv.getGeneratedQR}");

                            return snapshot.data != null
                                ? QrImage(
                                    data: snapshot.data as String,
                                    version: QrVersions.auto,
                                    size: 200.0,
                                  )
                                : Container();
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: Constants.padding / 2,
                  ),
                  Center(
                    child: TextWidget(
                      LocaleKeys.cashier_scan_statement.tr(),
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(
                      Constants.padding,
                    ),
                    child: Divider(
                      // color: AppColors.simeGray,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(
                      Constants.padding,
                    ),
                    child: VisitRestaurant(
                      isOrderDetails: true,
                      isHomePage: false,
                      userVisits: widget.userVisits,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Center(
                    child: Consumer(
                      builder: (context, ref, child) => FutureBuilder(
                        future: _fetchCheckOutFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                            if (snapshot.data is Failure) {
                              return Center(
                                  child: TextWidget(snapshot.data.toString()));
                            }
                            print("snapshot data is ${snapshot.data}");
                            var checkOutDetails =
                                snapshot.data as CheckOutDetails;

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Constants.padding,
                              ),
                              child: Column(
                                children: [
                                  checkOut("SubTotal",
                                      checkOutDetails.orderAmount.toString()),
                                  checkOut("Discount",
                                      checkOutDetails.discountAmount.toString(),
                                      isDiscount: true),
                                  checkOut(
                                      "Total (incl. VAT)",
                                      checkOutDetails.grandTotalAmount
                                          .toString()),
                                ],
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
                  const Divider(),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  const Center(child: TextWidget("Review Order")),
                  const Divider(),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  GestureDetector(
                    onTap: () {
                      // show dilog for rating
                      if (!isRated) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Review Visit",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                RatingBar.builder(
                                  initialRating: 0,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  updateOnDrag: false,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    this.rating = rating;
                                  },
                                ),
                                // write your comment here
                                SizedBox(
                                  height: size.height * 0.01,
                                ),

                                TextFormField(
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  controller: commentTextController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Write Your Comment",
                                  ),
                                ),

                                SizedBox(
                                  height: size.height * 0.03,
                                ),

                                // submit button
                                ButtonWidget(
                                  horizontalTextPadding: size.width * 0.08,
                                  verticalTextPadding: size.width * 0.01,
                                  onPressed: () {
                                    ref
                                        .watch(visitProvider)
                                        .postCreateVisitReview(
                                          comment: commentTextController.text,
                                          visitId: widget.userVisits!.id!,
                                          rating: rating,
                                        );
                                    isRated = true;
                                    Navigator.of(context).pop();
                                  },
                                  title: "Submit",
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                    child: Center(
                      child: RatingBar.builder(
                        initialRating: rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        glow: false,
                        ignoreGestures: true,
                        itemCount: 5,
                        updateOnDrag: false,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                ],
              ),
              Positioned(
                bottom: size.height * 0.01,
                left: context.locale.toString() == "ar"
                    ? null
                    : size.width * 0.02,
                right: context.locale.toString() == "ar"
                    ? size.width * 0.02
                    : null,
                child: GestureDetector(
                  onTap: () async {
                    await launch("https://wa.me/${number}");
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: SvgPicture.asset(
                          'assets/svg/ic_help.svg',
                          width: 25,
                          height: 25,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      TextWidget(
                        LocaleKeys.issue_statement.tr(),
                        color: AppColors.lightBlue,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget checkOut(String title, String value, {bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Constants.padding / 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            title,
            fontWeight: FontWeight.bold,
          ),
          TextWidget(
            isDiscount ? "-$value\$" : "$value\$",
            fontWeight: FontWeight.bold,
            color: isDiscount ? AppColors.red : AppColors.black,
          ),
        ],
      ),
    );
  }
}
