import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';

class GetActiveOffers extends BaseDioApi {
  GetActiveOffers() : super(ApiUrls.getActiveOffers);

  @override
  body() {
    return {
      "options": {"perPage": 5}
    };
  }

  Future fetch() async {
    final response = await postRequest();
    return response;
  }
}
