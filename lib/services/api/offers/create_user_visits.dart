import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';

class CreateUserVisits extends BaseDioApi {
  final String storeId;
  final String offerId;
  final String customerId;
  CreateUserVisits(
      {required this.storeId, required this.offerId, required this.customerId})
      : super(ApiUrls.getCreateUserVisits);

  @override
  body() {
    return {"storeId": storeId, "offerId": offerId, "customerId": customerId};
  }

  Future fetch() async {
    final response = await postRequest();
    return response;
  }
}
