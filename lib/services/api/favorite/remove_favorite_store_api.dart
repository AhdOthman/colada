import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';

class RemoveFavoriteStores extends BaseDioApi {
  String customerId;
  String storeId;

  RemoveFavoriteStores({required this.customerId, required this.storeId})
      : super(ApiUrls.removeFavoriteStores);

  @override
  body() {
    return {
      'userId': customerId,
      'storeId': storeId,
    };
  }

  Future fetch() async {
    final response = await postRequest();
    return response;
  }
}
