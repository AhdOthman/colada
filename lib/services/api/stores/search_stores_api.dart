import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';

class GetSearchStoresApi extends BaseDioApi {
  String searchTerm;

  GetSearchStoresApi({
    required this.searchTerm,
  }) : super(ApiUrls.getsearchStores);

  @override
  body() {
    return {
      'searchTerm': searchTerm,
    };
  }

  Future fetch() async {
    final response = await postRequest();
    return response;
  }
}
