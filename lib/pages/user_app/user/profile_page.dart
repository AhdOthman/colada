import 'package:coladaapp/generated/locale_keys.g.dart';
import 'package:coladaapp/provider/user/user_provider.dart';
import 'package:coladaapp/routes/routes.gr.dart';
import 'package:coladaapp/utils/constants/constants.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:coladaapp/widgets/app_bar_widget.dart';
import 'package:coladaapp/widgets/loader_widget.dart';
import 'package:coladaapp/widgets/subtitle_widget.dart';
import 'package:coladaapp/widgets/text_widget.dart';
import 'package:coladaapp/widgets/title_widget.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_share/social_share.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final user = ref.watch(userProvider).user;
    final referralCode = ref.watch(userProvider).referralCode;
    final imageUrl = ref.watch(userProvider).profileUrl ?? "";
    return Scaffold(
      appBar: AppBarWidget(
        title: LocaleKeys.profile_name.tr(),
        actions: [
          CupertinoButton(
            child: SvgPicture.asset('assets/icons/settings_icon.svg'),
            onPressed: () => context.router.push(AccountSettingsRoute()),
          )
        ],
      ),
      body: user == null
          ? const LoaderWidget()
          : SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              spreadRadius: 10,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 7), // changes position of shadow
                            ),
                          ],
                        ),
                        child: imageUrl == ""
                            ? SvgPicture.asset(
                                'assets/icons/profile2_icon.svg',
                                height: 120,
                                width: 120,
                              )
                            : Image.network(
                                imageUrl,
                                fit: BoxFit.fill,
                                width: 120,
                                height: 120,
                              ),
                      ),
                    ),
                  ),
                  onTap: () async {
                    final ImagePicker _picker = ImagePicker();
                    final XFile? image = await _picker
                        .pickImage(source: ImageSource.gallery)
                        .then((value) {
                      if (value != null) {
                        ref.read(userProvider).uploadUserPhoto(
                            customerId: ref.read(userProvider).user!.id!,
                            imageFile: value);
                      }
                    });
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: Constants.padding),
                  child: Center(
                    child: TextWidget(
                      user.name!,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Constants.padding),
                  child: TextWidget(
                    LocaleKeys.colada_cash_name.tr(),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      context.router.push(const CashbackHistoryRoute()),
                  child: Container(
                    width: size.width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/wallet_bg.png"),
                          fit: BoxFit.fill),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: context.locale.toString() == "ar"
                                  ? 0
                                  : Constants.padding * 4,
                              right: context.locale.toString() == "ar"
                                  ? Constants.padding * 4
                                  : 0,
                              top: Constants.padding * 4),
                          child: Row(
                            children: [
                              TitleWidget(
                                user.wallet!.balance.toString(),
                                color: AppColors.white,
                                fontSize: 40,
                              ),
                              const SizedBox(
                                width: Constants.padding / 2,
                              ),
                              const SubtitleWidget(
                                'SAR',
                                color: AppColors.darkBlue,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Constants.padding * 4,
                              vertical: Constants.padding * 3),
                          child: Row(
                            children: [
                              const TextWidget(
                                'Cashback Rate Increase by 1% every with\nevery visit During the same month',
                                color: AppColors.white,
                                fontSize: 7,
                              ),
                              const Spacer(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const TextWidget(
                                    'Cashback Rate',
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  TextWidget(
                                    "${(user.wallet!.cashbackRate! * 100)} %",
                                    color: AppColors.darkBlue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: Constants.padding * 3),
                Center(
                  child: TextWidget(
                    LocaleKeys.refer_a_friend_title.tr(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: Constants.padding / 2),
                Center(
                  child: TextWidget(
                    LocaleKeys.refer_a_friend_description.tr(),
                    textAlign: TextAlign.center,
                    color: AppColors.gray,
                  ),
                ),
                const SizedBox(height: Constants.padding),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      SocialShare.copyToClipboard("$referralCode");

                      SocialShare.shareOptions("$referralCode");
                    },
                    child: Container(
                      width: size.width * 0.7,
                      height: size.height * 0.07,
                      decoration: BoxDecoration(
                        color: AppColors.simeGray,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.share),
                          const SizedBox(width: Constants.padding / 2),
                          TextWidget(
                            '$referralCode',
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
    );
  }
}
