import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/polish_city.dart';
import '../modules/models/city_local_json.dart';

class GlobalController extends GetxController {
  GetStorage box = GetStorage();

  void unFocuseNode() {
    Get.focusScope!.unfocus();
  }
  List<City> _cities = [];
  void getCityToModel() {
    polishCity.forEach((element) {
      _cities.add(City.fromJson(element));
    });
  }


  List<City> getSuggestions(String pattern) {
    var suggestionCities = _cities.where((value) {
      return value.name.toLowerCase().startsWith(pattern.toLowerCase());
    }).toList();
    return suggestionCities;
  }

  bool isLoading = false;
  void toogleIsLoading() {
    isLoading = !isLoading;
    update();
  }


}
