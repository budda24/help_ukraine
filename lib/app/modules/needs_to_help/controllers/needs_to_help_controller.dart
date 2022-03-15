import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:pomoc_ukrainie/helpers/widgets/online_tribes/row_progress_dott.dart';

import '../../../infrastructure/fb_services/db_services/firebase.dart';
import '../../../infrastructure/fb_services/models/city_local_json.dart';
import '../../../infrastructure/fb_services/models/need.dart';

enum Language { pl, uk }

class NeedsToHelpController extends GetxController {
  TextEditingController cityController = TextEditingController();

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

  List<City> cityWithNeeds = [];

  List<City> getSuggestions(String pattern) {
    var suggestionCities = cityWithNeeds.where((value) {
      return value.name.toLowerCase().startsWith(pattern.toLowerCase());
    }).toList();
    return suggestionCities;
  }

  @override
  void onInit() async {
    cityWithNeeds = await DbFirebase().getCityWhereNeeds();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
