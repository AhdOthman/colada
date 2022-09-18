import 'dart:io';

import 'package:coladaapp/models/user/faq_model.dart';
import 'package:coladaapp/models/user/user_location_model.dart';
import 'package:coladaapp/models/user/user_model.dart';
import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/user/create_user_api.dart';
import 'package:coladaapp/services/api/user/faq_api.dart';
import 'package:coladaapp/services/api/user/generate_referral_code.dart';
import 'package:coladaapp/services/api/user/get_user_api.dart';
import 'package:coladaapp/services/api/user/update_profile.dart';
import 'package:coladaapp/services/api/user/update_user_api.dart';
import 'package:coladaapp/utils/failure.dart';
import 'package:coladaapp/utils/theme/app_colors.dart';
import 'package:coladaapp/utils/ui_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final userProvider =
    ChangeNotifierProvider<UserProvider>((ref) => UserProvider());

class UserProvider extends ChangeNotifier {
  String? referralCode;
  String? profileUrl;

  UserModel? _user;
  UserModel? get user => _user;

  List<FAQ>? _faqs;
  List<FAQ>? get getFAQList => _faqs;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  void setFAQ(List<FAQ>? faq) {
    _faqs = faq;
    notifyListeners();
  }

  void setReferralCode(String? code) {
    referralCode = code;
    notifyListeners();
  }

  void setProfilePhoto(String photoUrl) {
    profileUrl = photoUrl;
    notifyListeners();
  }

  Future createUser(String phoneNumber, String name) async {
    try {
      final response =
          await CreateUserApi(phoneNumber: phoneNumber, name: name).fetch();
      setUser(UserModel.fromJson(response['dataResponse']['user']));
      return _user;
    } on Failure catch (f) {
      //UIHelper.showNotification(f.message);
      return f;
    }
  }

  Future getUser(String customerId) async {
    try {
      final response = await GetUserApi(customerId: customerId).fetch();
      setUser(UserModel.fromJson(response['dataResponse']['user']));
      if (response['dataResponse']['user']['profileUrl'] != null) {
        setProfilePhoto(response['dataResponse']['user']['profileUrl']);
      }
      return _user;
    } on Failure catch (f) {
      UIHelper.showNotification(f.message);
      return f;
    }
  }

  Future getGenerateReferralCode(String customerId) async {
    try {
      final response =
          await GenerateReferralCode(customerId: customerId).fetch();

      String? code = response['dataResponse']['referralCode'];
      setReferralCode(response['dataResponse']['referralCode']);
      return code;
    } on Failure catch (f) {
      UIHelper.showNotification(f.message);
      return f;
    }
  }

  Future getFAQ() async {
    try {
      final response = await FAQApi().fetch();
      List<FAQ> faqList = [];
      for (var faq in response['dataResponse']['data']) {
        faqList.add(FAQ.fromJson(faq));
      }
      setFAQ(faqList);
      return faqList;
    } on Failure catch (f) {
      UIHelper.showNotification(f.message);
      return f;
    }
  }

  Future updateUser(String customerId, UserLocationModel location) async {
    try {
      final response =
          await UpdateUserApi(customerId: customerId, location: location)
              .fetch();
      setUser(UserModel.fromJson(response['dataResponse']['user']));
      return true;
    } on Failure catch (f) {
      UIHelper.showNotification(f.message);
      return false;
    }
  }

  Future updateProfile(
      {required String customerId, fullName, gender, dateOfBerth}) async {
    try {
      final response = await UpdateProfile(
              customerId: customerId,
              fullName: fullName,
              dateOfBirth: dateOfBerth,
              gender: gender)
          .fetch();
      setUser(UserModel.fromJson(response['dataResponse']['user']));
      UIHelper.showNotification("Profile Updated",
          backgroundColor: AppColors.green);

      return true;
    } on Failure catch (f) {
      UIHelper.showNotification(f.message);
      return false;
    }
  }

  Future uploadUserPhoto(
      {required String customerId, required XFile? imageFile}) async {
    String fileName = imageFile!.path.split('/').last;

    try {
      var dio = Dio(
        BaseOptions(
          baseUrl: ApiUrls.baseUrl,
          headers: {
            'Authorization': '',
            'Content-Type': 'multipart/form-data',
            'Accept': '*/*',
            'Accept-Encoding': 'gzip, deflate, br',
          },
          validateStatus: (status) {
            if (status == 500.511) {
              UIHelper.showNotification("Https server error");
              return false;
            } else if (status == 400.451) {
              UIHelper.showNotification("Failed to upload photo");

              return false;
            }
            return true;
          },
        ),
      );
      File _image = File(imageFile.path);
      var formData = FormData.fromMap({
        'customerId': customerId,
        'customerPhoto':
            await MultipartFile.fromFile(imageFile.path, filename: fileName),
      });
      final response =
          await dio.post('/uploads/uploadUserPhoto', data: formData);
      try {
        setProfilePhoto(response.data['dataResponse']['user']['profileUrl']);
        UIHelper.showNotification("Photo Updated",
            backgroundColor: AppColors.green);
      } catch (e) {
        UIHelper.showNotification("File is too large");
      }

      return true;
    } on Failure catch (f) {
      UIHelper.showNotification(f.message);
      return false;
    }
  }
}
