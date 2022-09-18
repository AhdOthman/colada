import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';

class FAQApi extends BaseDioApi {
  FAQApi() : super(ApiUrls.frequentAskedQuestion);

  @override
  body() {
    return {};
  }

  Future fetch() async {
    final response = await getRequest();
    return response;
  }
}
