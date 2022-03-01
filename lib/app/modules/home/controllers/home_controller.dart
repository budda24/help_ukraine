import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pomoc_ukrainie/app/data/polish_city.dart';
import 'package:pomoc_ukrainie/app/infrastructure/fb_services/db_services/db_postgresem.dart';

import '../models/city.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController needController = TextEditingController();

  List<City> cities = [];
  void getCityToModel() {
    /* List<City> tmpcities = []; */
    polishCity.forEach((element) {
      cities.add(City.fromJson(element));
    });
  }

  List<City> getSuggestions(String pattern) {
    var suggestionCities = cities.where((value) {
      return value.name.toLowerCase().startsWith(pattern.toLowerCase());
    }).toList();
    return suggestionCities;
  }

  void unFocuseNode() {
    Get.focusScope!.unfocus();
  }

  final count = 0.obs;
  @override
  void onInit() async {
    getCityToModel();
    print('init controller');
    await DbPosgress().createAlbum().catchError((onError) => print(onError)).then((value) => print(value.body));
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
