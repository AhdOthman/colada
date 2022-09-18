import 'package:coladaapp/models/user/user_location_model.dart';
import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';

class GetStoresApi extends BaseDioApi {
  UserLocationModel location;
  int? perPage;
  int? page;
  bool isFeatured;

  GetStoresApi(
      {required this.location,
      this.perPage = 3,
      this.page = 1,
      this.isFeatured = true})
      : super(ApiUrls.getStores);

  @override
  body() {
    return {
      'isFeatured': isFeatured,
      "query": {},
      'location': location.toJson(),
      "options": {"perPage": perPage, "page": page}
    };
  }

  Future fetch() async {
    final response = await postRequest();
    return response;
  }
}
