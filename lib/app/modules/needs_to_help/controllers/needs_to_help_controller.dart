import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pomoc_ukrainie/app/infrastructure/fb_services/models/city_with_needs.dart';
import 'package:pomoc_ukrainie/app/infrastructure/fb_services/models/need.dart';
import 'package:pomoc_ukrainie/helpers/widgets/online_tribes/row_progress_dott.dart';

import '../../../data/polish_city.dart';
import '../../../infrastructure/fb_services/db_services/firebase.dart';
import '../../../infrastructure/fb_services/models/city.dart';

enum Language { pl, uk }

class NeedsToHelpController extends GetxController {
  TextEditingController cityController = TextEditingController();
  var db = DbFirebase();

  Language currantLanguage = Language.pl;

  bool isPolish = true;
  toogleLanguage(Language language) {
    currantLanguage = language;
    update();
  }

  // String? description;

  // void toggleLanguage(Language language, Need need) {
  //   currantLanguage = language;
  //   switch (currantLanguage) {
  //     case Language.pl:
  //       description
  //       break;
  //       case Language.uk:

  //       break;
  //     default:
  //   }
  //   update();
  // }

  RxList<Need> needs = <Need>[].obs;
  Future<void> getNeedsCity(String city) async {
    needs.value = await DbFirebase().feachNeedsInCity(city);
  }

  List<CityWithNeeds> allCities = [];

  List<CityWithNeeds> getSuggestions(String pattern) {
    var suggestionCities = allCities.where((value) {
      return value.name.toLowerCase().startsWith(pattern.toLowerCase());
    }).toList();
    return suggestionCities;
  }

  Future<void> getCities() async {
    var statsCity = await db.feachCityStats();



    polishCity.forEach((element) {
      String cityId = element['id'];
      if(statsCity[cityId] != 0){
       var city = CityWithNeeds(
          quantity: statsCity[cityId].toString(), name: element['name']);
          allCities.add(city);
      }
    });
  }

  @override
  void onInit() async {
    await getCities();
    print('init');
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
