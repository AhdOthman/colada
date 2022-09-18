import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';

class UpdateProfile extends BaseDioApi {
  String customerId;
  String fullName;
  String gender;
  String dateOfBirth;

  UpdateProfile({
    required this.customerId,
    required this.fullName,
    required this.gender,
    required this.dateOfBirth,
  }) : super(ApiUrls.createUser);

  @override
  body() {
    return {
      'customerId': customerId,
      "gender": gender,
      "dob": dateOfBirth,
      "name": fullName
    };
  }

  Future fetch() async {
    final response = await putRequest();
    return response;
  }
}
