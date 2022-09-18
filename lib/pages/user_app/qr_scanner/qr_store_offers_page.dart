import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:coladaapp/pages/user_app/home/offers.dart';
import 'package:coladaapp/provider/qr/qr_provider.dart';
import 'package:coladaapp/provider/user/user_provider.dart';
import 'package:coladaapp/provider/visit/visit_provider.dart';
import 'package:coladaapp/routes/routes.gr.dart';
import 'package:coladaapp/utils/constants/constants.dart';
import 'package:coladaapp/widgets/app_bar_widget.dart';
import 'package:coladaapp/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QRStoreOffersPage extends ConsumerWidget {
  const QRStoreOffersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getChrckInQRList = ref.watch(qrProvider).getChrckInQRList ?? [];
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Scanner',
      ),
      body: ListView(
        children: [
          const TextWidget(
            'please select the offer that you want to eligible for',
            textAlign: TextAlign.center,
          ),
          ListView.builder(
            shrinkWrap: true,
            //     primary: false,
            padding: EdgeInsets.zero,
            itemCount: getChrckInQRList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: Constants.padding),
                child: GestureDetector(
                  onTap: () {
                    // context.router.push(
                    //     OfferDetailsRoute(offersList: getChrckInQRList[index]));
                    var user = ref.watch(userProvider).user;
                    ref
                        .watch(visitProvider)
                        .postCreateUserVisit(
                            storeId: getChrckInQRList[index].sid!,
                            offerId: getChrckInQRList[index].id!,
                            customerId: user!.id!)
                        .then((value) {
                      context.router.replace(BottomNavigationRoute(index: 2));
                    });
                  },
                  child: Offers(
                    offersModel: getChrckInQRList[index],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
