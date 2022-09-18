import 'package:coladaapp/main.dart';
import 'package:coladaapp/models/user/user_model.dart';
import 'package:coladaapp/pages/user_app/authentication/login_page.dart';
import 'package:coladaapp/provider/auth/auth_provider.dart';
import 'package:coladaapp/provider/user/user_provider.dart';
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
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as easy_localization;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';

final referralCodeProvider = StateProvider.autoDispose<String?>((ref) => null);
final newUserNameProvider = StateProvider.autoDispose<String?>((ref) => null);

class SignUpNewUserPage extends ConsumerWidget {
  SignUpNewUserPage({Key? key}) : super(key: key);

  final _correctNumberProvider =
      StateProvider.autoDispose<bool>((ref) => false);

  Future _fetchCreateUser(WidgetRef ref, BuildContext context,
      String phoneNumber, phoneNumberCode, name, refeealCode) async {
    final userProv = ref.read(userProvider);

    loadingDialog(context);
    final response = await AuthProvider.sighUpApi(
      '$phoneNumberCode$phoneNumber',
      name,
      refeealCode,
    );
    print(response);

    Navigator.pop(context);
    if (response is! Failure) {
      userProv
          .setUser(UserModel.fromJson(response['dataResponse']['signedUser']));
      context.router.push(const UserLocationRoute());
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBarWidget(
          title: "login".tr(),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              ListView(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Constants.padding,
                          vertical: Constants.padding),
                      child: TitleWidget(
                        'Your Information',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Constants.padding,
                      ),
                      child: TextWidget(
                        'Please enter your name and referral code if you \n have any',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: Constants.padding * 2),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Constants.padding,
                    ),
                    child: SubtitleWidget(
                      'Name',
                      color: AppColors.gray,
                    ),
                  ),
                  Consumer(builder: (context, ref, child) {
                    String? name = ref.watch(newUserNameProvider);
                    return Directionality(
                      textDirection: TextDirection.ltr,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Constants.padding,
                        ),
                        child: TextField(
                          keyboardType: TextInputType.name,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(25),
                            FilteringTextInputFormatter.allow(
                                Constants.regexName),
                          ],
                          onChanged: (value) {
                            ref.watch(newUserNameProvider.state).state = value;
                            ref.watch(_correctNumberProvider.state).state =
                                ref.watch(newUserNameProvider.state).state !=
                                        null
                                    ? true
                                    : false;
                          },
                          decoration: InputDecoration(
                            hintText: 'Mohannad Noman',
                            errorText: name != null && name.isEmpty
                                ? 'Enter your name'
                                : null,
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: Constants.padding * 2),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Constants.padding,
                    ),
                    child: SubtitleWidget(
                      'Referral Code',
                      color: AppColors.gray,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Constants.padding,
                    ),
                    child: Consumer(builder: (context, ref, child) {
                      var isCorrect = ref.watch(_correctNumberProvider);
                      var referralCodeProve = ref.watch(referralCodeProvider);
                      var nameProve = ref.watch(newUserNameProvider);

                      return Directionality(
                        textDirection: TextDirection.ltr,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: Constants.padding,
                          ),
                          child: TextField(
                            //  keyboardType: TextInputType.phone,
                            // inputFormatters: [
                            //   FilteringTextInputFormatter.digitsOnly,
                            //   LengthLimitingTextInputFormatter(9),
                            // ],
                            onChanged: (value) {
                              ref.read(referralCodeProvider.state).state =
                                  value;
                            },
                            decoration: const InputDecoration(
                              hintText: 'M4DC9RD',
                              // errorText: phoneNumber.length == 9
                              //     ? isCorrect
                              //         ? null
                              //         : 'Error number'
                              //     : null,
                            ),
                          ),
                        ),
                      );
                    }),
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
                  child: Consumer(builder: (context, ref, child) {
                    final isCorrect = ref.watch(_correctNumberProvider);
                    final referralCodeProv = ref.watch(referralCodeProvider);
                    final phoneNumberCode = ref.watch(phoneNumberCodeProvider);

                    final phoneNumber = ref.watch(phoneNumberProvider);

                    final name = ref.watch(newUserNameProvider);
                    print('name: $name');
                    return ButtonWidget(
                      title: 'Continue',
                      onPressed: name != null && name.isNotEmpty
                          ? () => _fetchCreateUser(ref, context, phoneNumber,
                              phoneNumberCode, name, referralCodeProv)
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
