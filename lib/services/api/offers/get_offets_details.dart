import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';

class GetOffersDetails extends BaseDioApi {
  String offerId;

  GetOffersDetails({
    required this.offerId,
  }) : super(ApiUrls.getOffersDetails);

  @override
  body() {
    return {
      "offerId": offerId,
    };
  }

  Future fetch() async {
    final response = await postRequest();
    return response;
  }
}
