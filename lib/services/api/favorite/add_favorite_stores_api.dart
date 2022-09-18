import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';

class AddFavoriteStores extends BaseDioApi {
  String customerId;
  String storeId;

  AddFavoriteStores({required this.customerId, required this.storeId})
      : super(ApiUrls.addFavoriteStores);

  @override
  body() {
    return {
      'customerId': customerId,
      'storeId': storeId,
    };
  }

  Future fetch() async {
    final response = await postRequest();
    print("fav response $response");
    return response;
  }
}
