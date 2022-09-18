import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';

class GetUserTransaction extends BaseDioApi {
  String customerId;

  GetUserTransaction({required this.customerId})
      : super(ApiUrls.getUserTransactions);

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
