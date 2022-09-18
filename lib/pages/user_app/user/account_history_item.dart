import 'package:coladaapp/generated/locale_keys.g.dart';
import 'package:coladaapp/models/notification/notification_model.dart';
import 'package:coladaapp/models/transaction/user_transaction_model.dart';
import 'package:coladaapp/provider/notifications/notification_provider.dart';
import 'package:coladaapp/provider/user/user_provider.dart';
import 'package:coladaapp/utils/constants/constants.dart';
import 'package:coladaapp/utils/failure.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:coladaapp/widgets/app_bar_widget.dart';
import 'package:coladaapp/widgets/loader_widget.dart';
import 'package:coladaapp/widgets/notifications_item_widget.dart';
import 'package:coladaapp/widgets/text_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class AccountHistoryItemPage extends ConsumerStatefulWidget {
  final UserTransaction userTransaction;

  const AccountHistoryItemPage(this.userTransaction, {Key? key})
      : super(key: key);

  @override
  _AccountHistoryItemPageState createState() => _AccountHistoryItemPageState();
}

class _AccountHistoryItemPageState
    extends ConsumerState<AccountHistoryItemPage> {
  getColor(String type) {
    switch (type) {
      case 'VALID':
        return AppColors.green;
      case 'Used':
        return AppColors.green;
      case 'Expired':
        return AppColors.red;
      case 'notused':
        return AppColors.red;
      default:
        return AppColors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final type = widget.userTransaction.type == "Percentage" ? "%" : "SAR";

    var inputFormat = DateFormat('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ');
    var inputDate = inputFormat
        .parse(widget.userTransaction.createdAt!); // <-- dd/MM 24H format

    var outputFormat = DateFormat('MMM, DD');
    var outputDate = outputFormat.format(inputDate);
    print("outputDate $outputDate"); // 12/31/2000 11:59 PM <-- MM/dd 12H format

    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Constants.padding, vertical: Constants.padding),
      child: Container(
        width: size.width * 0.9,
        decoration: BoxDecoration(
          color: AppColors.lightwhite,
          borderRadius: BorderRadius.circular(Constants.padding),
          boxShadow: [
            BoxShadow(
              color: AppColors.superLightBlue.withOpacity(0.1),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(Constants.padding),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Constants.padding, vertical: Constants.padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          "${widget.userTransaction.amount.toString()} $type",
                          color: AppColors.gold,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        TextWidget(
                          widget.userTransaction.type == "Percentage"
                              ? "Discount"
                              : "On Orders Above 100 SR ",
                          color: AppColors.darkBlue,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextWidget(
                          outputDate,
                          color: AppColors.superLightBlue,
                        ),
                        const SizedBox(height: Constants.padding / 4),
                        TextWidget(
                          "9:00-10:00pm",
                          color: AppColors.superLightBlue.withOpacity(0.6),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.lightwhite,
                borderRadius: BorderRadius.circular(Constants.padding),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Constants.padding, vertical: Constants.padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          LocaleKeys.visit_number_label_text.tr(),
                          color: AppColors.darkBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        TextWidget(
                          widget.userTransaction.v.toString(),
                          color: AppColors.superLightBlue,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: size.width * 0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SvgPicture.asset(
                                'assets/svg/Oval.svg',
                                color: getColor(widget.userTransaction.status!),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              SizedBox(
                                child: TextWidget(
                                  widget.userTransaction.status!.toUpperCase(),
                                  textAlign: TextAlign.end,
                                  color:
                                      getColor(widget.userTransaction.status!),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: Constants.padding / 4),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
