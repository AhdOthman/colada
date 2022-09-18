import 'dart:convert';

import 'package:coladaapp/generated/locale_keys.g.dart';
import 'package:coladaapp/models/user/user_model.dart';
import 'package:coladaapp/provider/auth/auth_provider.dart';
import 'package:coladaapp/provider/user/user_provider.dart';
import 'package:coladaapp/routes/routes.gr.dart';
import 'package:coladaapp/services/sherad_prefence/sherad_prefence.dart';
import 'package:coladaapp/utils/constants/constants.dart';
import 'package:coladaapp/utils/constants/keys.dart';
import 'package:coladaapp/utils/failure.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:coladaapp/utils/ui_helper.dart';
import 'package:coladaapp/widgets/app_bar_widget.dart';
import 'package:coladaapp/widgets/button_widget.dart';
import 'package:coladaapp/widgets/loading_dialog.dart';
import 'package:coladaapp/widgets/subtitle_widget.dart';
import 'package:coladaapp/widgets/text_widget.dart';
import 'package:coladaapp/widgets/title_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as easy_localization;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:auto_route/auto_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import 'login_page.dart';

class OtpPage extends ConsumerStatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpPage> {
  String _otp = "";

  Future _fetchVerifyOtp() async {
    final phoneNumber = ref.read(phoneNumberProvider);
    final phoneNumberCodeProv = ref.read(phoneNumberCodeProvider);
    final userProv = ref.read(userProvider);
    loadingDialog(context);
    final response = await AuthProvider.fetchVerifyOtp(
        '$phoneNumberCodeProv$phoneNumber',
        _otp,
        prefs.getString(Keys.deviceIdKey)!);
    Navigator.pop(context);
    print("_fetchVerifyOtp $response");

    print("response $response");
    if (response is! Failure) {
      userProv.setUser(UserModel.fromJson(
          response['dataResponse']['verificationDetails']['userData']));

      if (response['dataResponse']['verificationDetails']['action'] ==
          "REGISTER") {
        context.router.push(SignUpNewUserPageRoute());
      } else if (response['dataResponse']['verificationDetails']['action'] !=
              "REGISTER" &&
          userProv.user!.location == null) {
        context.router.push(const UserLocationRoute());
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString(Keys.hasSaveUserData,
            json.encoder.convert(userProv.user!.toJson()));

        context.router.push(BottomNavigationRoute());
      }
    }
    //_fetchCreateUser();
  }

  Future _fetchCreateOtp() async {
    final phoneNumber = ref.read(phoneNumberProvider);
    final phoneNumberCode = ref.read(phoneNumberCodeProvider);
    final response = await AuthProvider.fetchCreateOtp(
        phoneNumber, phoneNumberCode, prefs.getString(Keys.deviceIdKey)!);
    if (response is! Failure) {
      UIHelper.showNotification('Resend successfully',
          backgroundColor: AppColors.primaryColor);
    }
  }

  Future _fetchCreateUser() async {
    final phoneNumber = ref.read(phoneNumberProvider);
    final name = ref.read(nameProvider);
    final user = ref.read(userProvider);

    final response = await user.createUser(phoneNumber, name!);
    if (response != null) {
      context.router.push(const UserLocationRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
          title: "OTP".tr(),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Constants.padding,
                      vertical: Constants.padding),
                  child: TitleWidget(
                    LocaleKeys.verify_phone_number_title.tr(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Constants.padding,
                  ),
                  child: Consumer(builder: (context, ref, child) {
                    final phoneNumber = ref.watch(phoneNumberProvider);
                    return TextWidget(
                      '${LocaleKeys.verify_phone_number_description.tr()} 0$phoneNumber',
                      textAlign: TextAlign.center,
                    );
                  }),
                ),
              ),
              const SizedBox(height: Constants.padding * 2),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Constants.padding * 3,
                  ),
                  child: PinCodeTextField(
                    length: 4,
                    obscureText: false,
                    autoFocus: true,
                    animationType: AnimationType.fade,
                    textStyle: Theme.of(context).textTheme.caption,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      borderRadius: BorderRadius.circular(5),
                      activeFillColor: AppColors.black,
                      activeColor: AppColors.black,
                      inactiveColor: AppColors.gray,
                      selectedColor: AppColors.black,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: false,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onCompleted: (value) {
                      _otp = value;
                      _fetchVerifyOtp();
                    },
                    onChanged: (value) {
                      _otp = value;
                    },
                    beforeTextPaste: (text) {
                      debugPrint("Allowing to paste $text");
                      return true;
                    },
                    appContext: context,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Constants.padding,
                  vertical: Constants.padding,
                ),
                child: ButtonWidget(
                  title: LocaleKeys.continue_title.tr(),
                  onPressed: _fetchVerifyOtp,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(LocaleKeys.did_not_received_code_title.tr()),
                  CupertinoButton(
                      child: TextWidget(
                        LocaleKeys.resend_code_again_title.tr(),
                        color: AppColors.primaryColor,
                      ),
                      onPressed: _fetchCreateOtp)
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Constants.padding * 2,
                ),
                child: SubtitleWidget(
                    LocaleKeys.agree_on_conditions_description.tr(),
                    fontSize: Theme.of(context).textTheme.subtitle2!.fontSize,
                    textAlign: TextAlign.center),
              ),
            ],
          ),
        ));
  }
}
