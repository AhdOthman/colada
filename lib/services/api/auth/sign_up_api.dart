import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';

class SighUpApi extends BaseDioApi {
  String name;
  String phoneNumber;
  String? referralCode;

  SighUpApi({required this.phoneNumber, required this.name, this.referralCode})
      : super(ApiUrls.signUp);

  @override
  body() {
    return {
      "name": name,
      "did": "ds5432-fdss32",
      "phoneNumber": phoneNumber,
      "referralCode": null,
    };
  }

  Future fetch() async {
    final response = await postRequest();
    return response;
  }
}
