import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';

class GenerateVisitQR extends BaseDioApi {
  String visitId;

  GenerateVisitQR({
    required this.visitId,
  }) : super(ApiUrls.generateVisitQR);

  @override
  body() {
    return {"visitId": visitId};
  }

  Future fetch() async {
    final response = await postRequest();
    return response;
  }
}
