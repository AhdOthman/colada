import 'package:coladaapp/generated/locale_keys.g.dart';
import 'package:coladaapp/routes/routes.gr.dart';
import 'package:coladaapp/utils/constants/constants.dart';
import 'package:coladaapp/utils/constants/keys.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:coladaapp/widgets/app_bar_widget.dart';
import 'package:coladaapp/widgets/button_icon_widget.dart';
import 'package:coladaapp/widgets/subtitle_widget.dart';
import 'package:coladaapp/widgets/text_widget.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_route/auto_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';

class AccountSettingsPage extends ConsumerStatefulWidget {
  AccountSettingsPage({Key? key}) : super(key: key);

  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends ConsumerState<AccountSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: LocaleKeys.account_setting_title.tr(),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    onTap: () {
                      context.router.push(EditProfileRoute());
                    },
                    leading: SvgPicture.asset('assets/icons/profile2_icon.svg'),
                    title:
                        TextWidget(LocaleKeys.profile_information_option.tr()),
                    subtitle: SubtitleWidget(
                        LocaleKeys.profile_information_option_description.tr(),
                        color: AppColors.gray),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    onTap: () {
                      context.router.push(const NotfifcationsRoute());
                    },
                    leading:
                        SvgPicture.asset('assets/icons/notification2_icon.svg'),
                    title: TextWidget(LocaleKeys.notification_option.tr()),
                    subtitle: SubtitleWidget(
                        LocaleKeys.notification_option_description.tr(),
                        color: AppColors.gray),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    onTap: () {
                      context.router.push(const FagPageRoute());
                    },
                    leading: SvgPicture.asset('assets/icons/faq_icon.svg'),
                    title: const TextWidget('Faq'),
                    subtitle: const SubtitleWidget('Frequently asked questions',
                        color: AppColors.gray),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    onTap: () {
                      // change language custom dialog-for text
                      showDialog(
                        context: context,
                        builder: (context) =>
                            Consumer(builder: (context, ref, child) {
                          var lang = context.locale.languageCode == 'ar'
                              ? false
                              : true;

                          return AlertDialog(
                            title: Text(
                                LocaleKeys.change_language_options_title.tr()),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: Text(
                                      LocaleKeys.english_language_option.tr()),
                                  trailing: Container(
                                    decoration: BoxDecoration(
                                      color: lang
                                          ? AppColors.orange
                                          : AppColors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Icon(
                                        Icons.done,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    context.setLocale(
                                      Locale('en'),

                                      // change language
                                    );
                                    Navigator.of(context).pop();
                                    //   RestartWidget.restartApp(context);
                                  },
                                ),
                                ListTile(
                                  title: Text(
                                      LocaleKeys.arabic_language_option.tr()),
                                  trailing: Container(
                                    decoration: BoxDecoration(
                                      color: lang
                                          ? AppColors.white
                                          : AppColors.orange,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Icon(
                                        Icons.done,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    context.setLocale(Locale('ar'));
                                    Navigator.of(context).pop();
                                    //      RestartWidget.restartApp(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        }),
                      );
                    },
                    leading: SvgPicture.asset('assets/icons/language_icon.svg'),
                    title: TextWidget(LocaleKeys.language_option.tr()),
                    subtitle: SubtitleWidget(
                        LocaleKeys.change_language_options_title.tr(),
                        color: AppColors.gray),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Constants.padding,
                        vertical: Constants.padding),
                    child: ButtonIconWidget(
                      title: LocaleKeys.logout_text.tr(),
                      textColor: AppColors.white,
                      backgroundColor: AppColors.red,
                      onPressed: () async {
                        SharedPreferences? _prefs =
                            await SharedPreferences.getInstance();
                        _prefs.remove(Keys.hasSaveUserData);
                        context.router.replaceAll([LoginRoute()]);
                      },
                      icon: SvgPicture.asset('assets/icons/logout_icon.svg'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
