import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';

class GetUserVisits extends BaseDioApi {
  String customerId;
  int? perPage;
  int? page;
  GetUserVisits({required this.customerId, this.perPage = 2, this.page = 1})
      : super(ApiUrls.getUserVisits);

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
