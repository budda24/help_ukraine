
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pomoc_ukrainie/app/infrastructure/fb_services/models/city_with_needs.dart';
import 'package:pomoc_ukrainie/app/infrastructure/fb_services/models/need.dart';

import '../../../data/polish_city.dart';
import '../../../infrastructure/fb_services/db_services/firebase.dart';

enum Language { pl, uk }

class NeedsToHelpController extends GetxController {
  TextEditingController cityController = TextEditingController();
  var db = DbFirebase();

  Language currantLanguage = Language.pl;

  toogleLanguage(Language language) {
    currantLanguage = language;
    update();
  }

  RxList<Need> needs = <Need>[].obs;
  void getNeedsInCity() async {
    var needsQuery =
        await DbFirebase().feachNeedsInCity(cityName!, itemLimit.value);

    var needsSnapshot = await needsQuery.get();
    needsSnapshot.docs.forEach((element) {
      needs.add(Need.fromJson(element.data()));
    });

    currentItemLength.value = needsSnapshot.docs.length;
  }

  List<CityWithNeeds> allCities = [];

  List<CityWithNeeds> getSuggestions(String pattern) {
    var suggestionCities = allCities.where((value) {
      return value.name.toLowerCase().startsWith(pattern.toLowerCase());
    }).toList();
    return suggestionCities;
  }

  Future<void> getCitiesWithNeeds() async {
    var statsCity = await db.feachCityStats();
    polishCity.forEach((element) {
      String cityId = element['id'];
      if (statsCity[cityId] != 0) {
        var city = CityWithNeeds(
            quantity: statsCity[cityId].toString(), name: element['name']);
        allCities.add(city);
      }
    });
  }

  final ScrollController scrollController = ScrollController();
  RxInt itemLimit = 10.obs;
  RxInt currentItemLength = 0.obs;
  RxInt previousItemLength = 0.obs;
  String? cityName;

  void scrollListener() {
    if (scrollController.offset >=
            scrollController.position.maxScrollExtent - 100 &&
        !scrollController.position.outOfRange) {
      if (previousItemLength != currentItemLength) {
        previousItemLength = currentItemLength;
        itemLimit = itemLimit + 10;
        getNeedsInCity();
      }
    }
  }

  @override
  void onInit() async {
    scrollController.addListener(scrollListener);
    print('needs to help controller init');
    await getCitiesWithNeeds();
    var cityStats = db.feachCityStats;

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.dispose();
  }
}
