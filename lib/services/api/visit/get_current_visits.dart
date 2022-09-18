import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';

class GetCurrentVisits extends BaseDioApi {
  String customerId = "";

  GetCurrentVisits({required this.customerId})
      : super(ApiUrls.getCurrentVisits);

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
