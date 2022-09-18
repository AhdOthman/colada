import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';

class VerifyOtpApi extends BaseDioApi {
  String phoneNumber;

  String deviceId;
  String otp;

  VerifyOtpApi(
      {required this.phoneNumber, required this.deviceId, required this.otp})
      : super(ApiUrls.verifyOTP);

  @override
  body() {
    return {
      'phoneNumber': phoneNumber,
      'deviceId': deviceId,
      'otp': otp,
    };
  }

  Future fetch() async {
    final response = await postRequest();
    return response;
  }
}
