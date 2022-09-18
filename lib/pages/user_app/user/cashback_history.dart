import 'package:coladaapp/generated/locale_keys.g.dart';
import 'package:coladaapp/pages/user_app/user/cashback_history_widget.dart';
import 'package:coladaapp/provider/transaction/Transaction.dart';
import 'package:coladaapp/provider/user/user_provider.dart';
import 'package:coladaapp/utils/failure.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:coladaapp/widgets/app_bar_widget.dart';
import 'package:coladaapp/widgets/loader_widget.dart';
import 'package:coladaapp/widgets/text_widget.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'account_history_item.dart';

class CashbackHistory extends ConsumerStatefulWidget {
  const CashbackHistory({Key? key}) : super(key: key);

  @override
  _CashbackHistoryState createState() => _CashbackHistoryState();
}

class _CashbackHistoryState extends ConsumerState<CashbackHistory> {
  late Future _fetchChashBackFuture;

  @override
  void initState() {
    _fetchChashBackFuture = _fetchChashBack();

    // _getUserVisitsFuture = _fetchGetFeaturedUserVisit();
    super.initState();
  }

  Future _fetchChashBack() async {
    final userProv = ref.read(userProvider);
    final transactionProv = ref.read(transactionProvider);
    return await transactionProv.getUserTransaction(userProv.user!.id!);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: Future.wait([_fetchChashBackFuture]),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.hasError);
          return const Center(child: TextWidget('Something Wrong'));
        } else if (snapshot.hasData) {
          if (snapshot.data is Failure) {
            return Center(child: TextWidget(snapshot.data.toString()));
          }
          return Scaffold(
            appBar: AppBarWidget(
              title: LocaleKeys.cashback_title.tr(),
            ),
            body: SizedBox(
              width: size.width,
              //   height: 300,
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final getUserTransactionList =
                      ref.watch(transactionProvider).getUserTransactionList ??
                          [];
                  return getUserTransactionList.isNotEmpty
                      ? ListView.builder(
                          itemCount: getUserTransactionList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {},
                                child: AccountHistoryItemPage(
                                  getUserTransactionList[index],
                                ));
                          },
                        )
                      : const Center(
                          child: TextWidget(
                          "unfortunately, There is no data available yet",
                          color: AppColors.gray,
                        ));
                  ;
                },
              ),
            ),
          );
        }
        return const LoaderWidget();
      },
    );
  }
}
