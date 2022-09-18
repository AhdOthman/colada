import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';

class GetUserNotification extends BaseDioApi {
  String customerId;

  GetUserNotification({required this.customerId})
      : super(ApiUrls.getUserNotification);

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
