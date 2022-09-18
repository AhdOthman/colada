import 'package:coladaapp/services/api/auth/create_otp_api.dart';
import 'package:coladaapp/services/api/auth/sign_up_api.dart';
import 'package:coladaapp/services/api/auth/verify_otp_api.dart';
import 'package:coladaapp/utils/failure.dart';
import 'package:coladaapp/utils/ui_helper.dart';

class AuthProvider {
  static Future fetchCreateOtp(
      String phoneNumber, phoneNumberCode, String deviceId) async {
    try {
      return await CreateOtpApi(
              phoneNumber: phoneNumber,
              phoneNumberCode: phoneNumberCode,
              deviceId: deviceId)
          .fetch();
    } on Failure catch (f) {
      UIHelper.showNotification(f.message);
      return f;
    }
  }

  static Future fetchVerifyOtp(
      String phoneNumber, String otp, String deviceId) async {
    try {
      return await VerifyOtpApi(
              phoneNumber: phoneNumber, otp: otp, deviceId: deviceId)
          .fetch();
    } on Failure catch (f) {
      UIHelper.showNotification(f.message);
      return f;
    }
  }

  static Future sighUpApi(
      String phoneNumber, String name, String? referralCode) async {
    try {
      return await SighUpApi(
              phoneNumber: phoneNumber, name: name, referralCode: referralCode)
          .fetch();
    } on Failure catch (f) {
      UIHelper.showNotification(f.message);
      return f;
    }
  }
}
