import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';

class GetStoreOffers extends BaseDioApi {
  String storeId;

  GetStoreOffers({
    required this.storeId,
  }) : super(ApiUrls.getOffers);

  @override
  body() {
    return {
      "storeId": storeId,
      "options": {"perPage": 5, "page": 1}
    };
  }

  Future fetch() async {
    final response = await postRequest();
    return response;
  }
}
