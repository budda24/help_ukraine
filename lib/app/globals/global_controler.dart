import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/polish_city.dart';
import '../infrastructure/fb_services/models/city.dart';

class GlobalController extends GetxController {
  GetStorage box = GetStorage();

  void unFocuseNode() {
    Get.focusScope!.unfocus();
  }

  List<City> cities = [];
  void getCityToModel() {
    polishCity.forEach((element) {
      cities.add(City.fromJson(element));
    });
  }

  List<City> getSuggestions(String pattern) {
    getCityToModel();
    var suggestionCities = cities.where((value) {
      return value.name.toLowerCase().startsWith(pattern.toLowerCase());
    }).toList();
    return suggestionCities;
  }

  String finCityId(String city) {
    var foundCity = polishCity.firstWhere((element) =>
        element['name'].toString().toLowerCase() == city.toLowerCase());
    return foundCity['id'];
  }

  bool isLoading = false;
  void toogleIsLoading() {
    isLoading = !isLoading;
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }
}
