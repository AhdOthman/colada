import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';

class GetFavoriteStores extends BaseDioApi {
  String customerId;
  int? perPage;
  int? page;
  GetFavoriteStores(
      {required this.customerId, required this.perPage, required this.page})
      : super(ApiUrls.getFavoriteStores);

  @override
  body() {
    return {
      'customerId': customerId,
      "options": {"perPage": perPage, "page": page}
    };
  }

  Future fetch() async {
    final response = await postRequest();
    return response;
  }
}
