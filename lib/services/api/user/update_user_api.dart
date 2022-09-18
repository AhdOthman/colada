import 'package:coladaapp/models/user/user_location_model.dart';
import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';

class UpdateUserApi extends BaseDioApi {
  String customerId;
  UserLocationModel location;

  UpdateUserApi({required this.customerId, required this.location})
      : super(ApiUrls.createUser);

  @override
  body() {
    return {
      'customerId': customerId,
      'location': location,
    };
  }

  Future fetch() async {
    final response = await putRequest();
    return response;
  }
}
