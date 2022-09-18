import 'package:coladaapp/services/api/api_urls.dart';
import 'package:coladaapp/services/api/base_dio_api.dart';

class GetFiltterStores extends BaseDioApi {
  List<String> cuisines;
  List<String> categories;
  Map<String, dynamic> workingHours;

  GetFiltterStores(
      {required this.cuisines,
      required this.categories,
      required this.workingHours})
      : super(ApiUrls.getFilters);

  @override
  body() {
    return {
      "cuisines": cuisines,
      "categories": categories,
      "workingHours": {
        "weekday": "Friday",
        "openingTime": "Xy5`VaH_ea",
        "closingTime": ",^[Hby@u':"
      },
      "options": {"perPage": 6}
    };
  }

  Future fetch() async {
    final response = await postRequest();
    print("GetFiltterStores $response");
    return response;
  }
}
