import 'package:coladaapp/generated/locale_keys.g.dart';
import 'package:coladaapp/main.dart';
import 'package:coladaapp/provider/auth/auth_provider.dart';
import 'package:coladaapp/routes/routes.gr.dart';
import 'package:coladaapp/utils/constants/constants.dart';
import 'package:coladaapp/utils/constants/keys.dart';
import 'package:coladaapp/utils/failure.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:coladaapp/utils/validation.dart';
import 'package:coladaapp/widgets/app_bar_widget.dart';
import 'package:coladaapp/widgets/button_widget.dart';
import 'package:coladaapp/widgets/loading_dialog.dart';
import 'package:coladaapp/widgets/subtitle_widget.dart';
import 'package:coladaapp/widgets/text_widget.dart';
import 'package:coladaapp/widgets/title_widget.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as easy_localization;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';

final phoneNumberProvider = StateProvider.autoDispose<String>((ref) => '');
final phoneNumberCodeProvider = StateProvider.autoDispose<String>((ref) => '');
final nameProvider = StateProvider.autoDispose<String?>((ref) => null);

class LoginPage extends ConsumerWidget {
  LoginPage({Key? key}) : super(key: key);

  final _correctNumberProvider =
      StateProvider.autoDispose<bool>((ref) => false);

  Future _fetchCreateOtp(
      BuildContext context, String phoneNumber, phoneNumberCode) async {
    loadingDialog(context);
    final response = await AuthProvider.fetchCreateOtp(
        phoneNumber, phoneNumberCode, prefs.getString(Keys.deviceIdKey)!);
    Navigator.pop(context);
    if (response is! Failure) {
      context.router.push(const OtpRoute());
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBarWidget(
          title: LocaleKeys.login_title.tr(),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              ListView(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Constants.padding,
                          vertical: Constants.padding),
                      child: TitleWidget(
                        LocaleKeys.getting_started_title.tr(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Constants.padding,
                      ),
                      child: TextWidget(
                        LocaleKeys.asking_mobile.tr(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: Constants.padding * 2),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Constants.padding,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Constants.padding,
                    ),
                    child: SubtitleWidget(
                      LocaleKeys.phone_number_title.tr(),
                      color: AppColors.gray,
                    ),
                  ),
                  Consumer(builder: (context, ref, child) {
                    var isCorrect = ref.watch(_correctNumberProvider);
                    var phoneNumber = ref.watch(phoneNumberProvider);

                    return Directionality(
                      textDirection: TextDirection.ltr,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: Constants.padding,
                        ),
                        child: Row(
                          children: [
                            CountryCodePicker(
                              onChanged: (value) {
                                print(value.code);
                                ref.read(phoneNumberCodeProvider.state).state =
                                    value.dialCode!;
                              },
                              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                              initialSelection: 'SA',
                              //  favorite: ['+39', 'FR'],
                              // optional. Shows only country name and flag
                              showCountryOnly: false,

                              // optional. Shows only country name and flag when popup is closed.
                              showOnlyCountryWhenClosed: false,
                              // optional. aligns the flag and the Text left
                              alignLeft: false,
                            ),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(9),
                                ],
                                onChanged: (value) {
                                  ref.read(_correctNumberProvider.state).state =
                                      Validation.isCorrectNumber(value);
                                  ref.read(phoneNumberProvider.state).state =
                                      value;
                                },
                                decoration: InputDecoration(
                                  hintText: '5xxxxxxxx',
                                  errorText: phoneNumber.length == 9
                                      ? isCorrect
                                          ? null
                                          : 'Error number'
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
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
                  child: Consumer(builder: (context, ref, child) {
                    final isCorrect = ref.watch(_correctNumberProvider);
                    final phoneNumber = ref.watch(phoneNumberProvider);
                    final phoneNumberCode = ref.watch(phoneNumberCodeProvider);
                    print(phoneNumberCode);
                    final name = ref.watch(nameProvider);
                    return ButtonWidget(
                      title: LocaleKeys.next_button.tr(),
                      onPressed: isCorrect
                          ? () => _fetchCreateOtp(
                              context, phoneNumber, phoneNumberCode)
                          : null,
                      textColor:
                          isCorrect ? AppColors.black : AppColors.lightGray,
                    );
                  }),
                ),
              ),
            ],
          ),
        ));
  }
}
