import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';

class CreateOtpApi extends BaseDioApi {
  String phoneNumber;
  String phoneNumberCode;
  String deviceId;

  CreateOtpApi(
      {required this.phoneNumber,
      required this.deviceId,
      required this.phoneNumberCode})
      : super(ApiUrls.createOtp);

  @override
  body() {
    return {
      'phoneNumber': '$phoneNumberCode$phoneNumber',
      'deviceId': deviceId,
      "did": "ds5432-fdss32"
    };
  }

  Future fetch() async {
    final response = await postRequest();
    return response;
  }
}
