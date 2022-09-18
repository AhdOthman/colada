import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';

class CheckinQR extends BaseDioApi {
  String storeId;

  CheckinQR({
    required this.storeId,
  }) : super(ApiUrls.getCheckInQR);

  @override
  body() {
    return {
      "data": {"storeId": storeId}
    };
  }

  Future fetch() async {
    final response = await postRequest();
    return response;
  }
}
