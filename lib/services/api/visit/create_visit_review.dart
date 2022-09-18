import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';

class CreateVisitReview extends BaseDioApi {
  String visitId;
  double rating;
  String comment;

  CreateVisitReview(
      {required this.visitId, required this.rating, required this.comment})
      : super(ApiUrls.getCreateVisitReview);

  @override
  body() {
    return {"visitId": visitId, "rating": rating, "comment": comment};
  }

  Future fetch() async {
    final response = await postRequest();
    return response;
  }
}
