import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';

class CreateUserApi extends BaseDioApi {
  String phoneNumber;
  String name;

  CreateUserApi({required this.phoneNumber, required this.name})
      : super(ApiUrls.createUser);

  @override
  body() {
    return {
      'phoneNumber': phoneNumber,
      'name': name,
    };
  }

  Future fetch() async {
    final response = await postRequest();
    return response;
  }
}
