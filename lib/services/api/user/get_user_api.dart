import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';

class GetUserApi extends BaseDioApi {
  String customerId;

  GetUserApi({required this.customerId}) : super(ApiUrls.getUser);

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
