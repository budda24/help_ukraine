import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pomoc_ukrainie/app/infrastructure/fb_services/models/city_with_needs.dart';
import 'package:pomoc_ukrainie/app/modules/models/need.dart';
import 'package:pomoc_ukrainie/helpers/widgets/online_tribes/row_progress_dott.dart';

import '../../../infrastructure/fb_services/db_services/firebase.dart';
import '../../models/city_local_json.dart';

class NeedsToHelpController extends GetxController {
  TextEditingController cityController = TextEditingController();

  RxList<Need> needs = <Need>[].obs;
  Future<void> getNeedsCity(String city) async {
    needs.value = await DbFirebase().feachNeedsInCity(city);
  }

  List<CityWithNeeds> cityWithNeeds = [];

  List<CityWithNeeds> getSuggestions(String pattern) {
    var suggestionCities = cityWithNeeds.where((value) {
      return value.name.toLowerCase().startsWith(pattern.toLowerCase());
    }).toList();
    return suggestionCities;
  }

  @override
  void onInit()async {
   cityWithNeeds = await DbFirebase().feachCityWhereNeeds();
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
