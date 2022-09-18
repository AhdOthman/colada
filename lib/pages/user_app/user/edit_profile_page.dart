import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:coladaapp/generated/locale_keys.g.dart';
import 'package:coladaapp/provider/user/user_provider.dart';
import 'package:coladaapp/routes/routes.gr.dart';
import 'package:coladaapp/utils/constants/constants.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:coladaapp/utils/ui_helper.dart';
import 'package:coladaapp/widgets/app_bar_widget.dart';
import 'package:coladaapp/widgets/button_widget.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final genderProvider = StateProvider.autoDispose<bool>((ref) => true);
final dateProvider = StateProvider.autoDispose<String>((ref) => "");

class EditProfilePage extends StatelessWidget {
  EditProfilePage({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Profile Settings',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Constants.padding),
        child: Stack(
          children: [
            ListView(
              children: [
                const SizedBox(height: 20),
                Consumer(
                  builder: (context, ref, child) {
                    return TextField(
                      controller: nameController
                        ..text =
                            ref.read(userProvider).user!.name ?? "Full Name",
                      decoration: const InputDecoration(
                        labelText: 'FULL NAME',
                        labelStyle: TextStyle(
                          color: AppColors.gray,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),
                Consumer(
                  builder: (context, ref, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "GENDERE",
                        style: TextStyle(
                          color: AppColors.gray,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Constants.padding,
                            ),
                            child: ButtonWidget(
                              verticalTextPadding: Constants.padding / 2.5,
                              title: 'MALE',
                              horizontalTextPadding: Constants.padding,
                              backgroundColor:
                                  ref.watch(genderProvider.state).state
                                      ? AppColors.primaryColor
                                      : AppColors.simeGray,
                              onPressed: () {
                                ref.watch(genderProvider.state).state = true;
                              },
                              textColor: AppColors.black,
                            ),
                          ),
                          ButtonWidget(
                            verticalTextPadding: Constants.padding / 2.5,
                            horizontalTextPadding: Constants.padding,
                            backgroundColor:
                                !ref.watch(genderProvider.state).state
                                    ? AppColors.primaryColor
                                    : AppColors.simeGray,
                            title: 'FEMALE',
                            onPressed: () {
                              ref.watch(genderProvider.state).state = false;
                            },
                            textColor: AppColors.black,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                const Divider(
                  color: AppColors.gray,
                  thickness: 1,
                ),
                const SizedBox(height: 20),
                Consumer(
                  builder: (context, ref, child) => GestureDetector(
                    onTap: () async {
                      ref.watch(dateProvider.state).state =
                          (await _selectDate(context)) as String;
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "DATE OF BIRTH",
                          style: TextStyle(
                            color: AppColors.gray,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Consumer(
                          builder: (context, ref, child) => SizedBox(
                            width: double.infinity,
                            height: 20,
                            child: Text(
                              ref.watch(dateProvider.state).state == ""
                                  ? ref.read(userProvider).user!.dob ??
                                      "MM/DD/YYYY"
                                  : ref.watch(dateProvider.state).state,
                            ),
                          ),
                        ),
                        const Divider(
                          color: AppColors.gray,
                          thickness: 1,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Gender
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
                child: Consumer(
                  builder: (context, ref, child) => ButtonWidget(
                    title: LocaleKeys.change_setting_option.tr(),
                    onPressed: () async {
                      if (nameController.text.isNotEmpty) {
                        final userProv = ref.read(userProvider);
                        final gender = ref.read(genderProvider.state).state;
                        final userDate = userProv.user!.dob == ""
                            ? "MM/DD/YYYY"
                            : userProv.user!.dob;
                        final dateString =
                            ref.watch(dateProvider.state).state == ""
                                ? userDate
                                : ref.watch(dateProvider.state).state;

                        return await userProv
                            .updateProfile(
                                customerId: userProv.user!.id!,
                                dateOfBerth: dateString,
                                fullName: nameController.text,
                                gender: gender ? "MALE" : "FEMALE")
                            .then((value) {
                          context.router.popUntilRouteWithName(
                              BottomNavigationRoute.name);
                        });
                      } else {
                        UIHelper.showNotification("Please enter your name");
                      }
                    },
                    textColor: AppColors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      currentDate: DateTime.now(),
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(2023),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: Colors.black,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      return "${picked.day}-${picked.month}-${picked.year}";
    }
    return null;
  }
}
