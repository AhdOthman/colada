import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';

class GenerateReferralCode extends BaseDioApi {
  String customerId;

  GenerateReferralCode({
    required this.customerId,
  }) : super(ApiUrls.getGenerateReferralCode);

  @override
  body() {
    return {
      'customerId': customerId,
    };
  }

  Future fetch() async {
    final response = await postRequest();
    return response;
  }
}
