import 'package:coladaapp/generated/locale_keys.g.dart';
import 'package:coladaapp/models/transaction/user_transaction_model.dart';
import 'package:coladaapp/utils/constants/constants.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:coladaapp/widgets/subtitle_widget.dart';
import 'package:coladaapp/widgets/text_widget.dart';
import 'package:coladaapp/widgets/title_widget.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

class CashbackHistoryWidget extends StatelessWidget {
  final UserTransaction userTransaction;
  const CashbackHistoryWidget({Key? key, required this.userTransaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Column(
        children: [
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Constants.padding,
                      horizontal: Constants.padding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleWidget(
                            userTransaction.amount.toString(),
                            color: AppColors.gold,
                          ),
                          SubtitleWidget(userTransaction.type!,
                              color: AppColors.darkBlue),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          TextWidget(
                            'Nov 10th',
                            color: AppColors.darkBlue,
                          ),
                          SubtitleWidget('2019', color: AppColors.gray),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Constants.padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      LocaleKeys.visit_number_label_text.tr(),
                      color: AppColors.darkBlue,
                    ),
                    const SubtitleWidget('#1234', color: AppColors.gray),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextWidget(
                      userTransaction.status!,
                      color: AppColors.green,
                    ),
                    const SubtitleWidget('2019', color: AppColors.gray),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
