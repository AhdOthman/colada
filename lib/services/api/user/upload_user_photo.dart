import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';
import 'package:image_picker/image_picker.dart';

class UploadPhoto extends BaseDioApi {
  String customerId;
  XFile? imageFile;

  UploadPhoto({
    required this.customerId,
    required this.imageFile,
  }) : super(ApiUrls.uploadUserPhoto);

  @override
  body() {
    return {
      'customerId': customerId,
      "customerPhoto": imageFile,
    };
  }

  Future fetch() async {
    final response = await putRequest();
    return response;
  }
}
