import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';

class GetCheckOutDetails extends BaseDioApi {
  String visitId = "";

  GetCheckOutDetails({required this.visitId})
      : super(ApiUrls.getCheckoutDetails);

  @override
  body() {
    return {
      'visitId': visitId,
    };
  }

  Future fetch() async {
    final response = await postRequest();
    return response;
  }
}
