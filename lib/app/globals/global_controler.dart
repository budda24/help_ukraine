import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pomoc_ukrainie/app/infrastructure/fb_services/db_services/firebase.dart';

import '../data/polish_city.dart';
import '../modules/home/controllers/home_controller.dart';
import '../infrastructure/fb_services/models/city_local_json.dart';

class GlobalController extends GetxController {
  GetStorage box = GetStorage();

  void unFocuseNode() {
    Get.focusScope!.unfocus();
  }

  List<City> getCityToModel() {
    List<City> cities = [];
    polishCity.forEach((element) {
      cities.add(City.fromJson(element));
    });
    return cities;
  }

  bool doesSuggestionExist = true;

  Future<List<City>> getSuggestions(String pattern, String whichJson) async {
    List<City> cities = [];
    if (whichJson == 'firestore') {
      cities = await DbFirebase().getCityWhereNeeds();
    } else {
      cities = getCityToModel();
    }

    var suggestionCities = cities.where((value) {
      return value.name.toLowerCase().startsWith(pattern.toLowerCase());
    }).toList();
    doesSuggestionExist = false;
    return suggestionCities;
  }

  bool isLoading = false;
  void toogleIsLoading() {
    isLoading = !isLoading;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
  }
}
