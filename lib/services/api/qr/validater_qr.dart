import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';

class ValidateQR extends BaseDioApi {
  String qrData;

  ValidateQR({
    required this.qrData,
  }) : super(ApiUrls.getValidateQR);

  @override
  body() {
    return {"data": qrData};
  }

  Future fetch() async {
    final response = await postRequest();
    return response;
  }
}
