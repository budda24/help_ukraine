import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pomoc_ukrainie/app/data/polish_city.dart';
import 'package:pomoc_ukrainie/app/infrastructure/fb_services/db_services/db_postgresem.dart';
import 'package:pomoc_ukrainie/app/modules/home/models/need.dart';

import '../../../../helpers/theme/alert_styles.dart';
import '../models/city.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  TextEditingController nameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController needTitleController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  List<City> _cities = [];
  void getCityToModel() {
    /* List<City> tmpcities = []; */
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

  String? validateTextField(String text) {
    String errorMessage = '';
    if (text.isEmpty) {
      errorMessage += 'Ви повинні заповнити всі поля';
    }

    RegExp regExpUaWords = RegExp(
      //only numbers and characters grek & ukrainians
      r"^[a-zA-Zа-яА-Яє-їЄ-Ї0-9\s]*$",
      caseSensitive: false,
      multiLine: false,
    );
    if (!regExpUaWords.hasMatch(text)) {
      errorMessage += '\nдозволені лише літери та цифри';
    }

    if (!errorMessage.isEmpty) {
      return errorMessage;
    } else
      return null;
  }

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  Future<void>postNeed() async {
    if (validateForm()) {
      var need = Need(
          needTitle: needTitleController.text,
          needDescription: descriptionController.text,
          contact: int.parse(contactNumberController.text),
          city: cityController.text,
          email: 'test@test.com');
      try {
        await DbPosgress().createAlbum(need).then((value) => print(value.body));
      } catch (e) {
        Get.showSnackbar(
            customSnackbar('надіслати потребу не вдалося, тому що: $e'));
      }
    }
  }

  void unFocuseNode() {
    Get.focusScope!.unfocus();
  }

  final count = 0.obs;
  @override
  void onInit() async {
    getCityToModel();
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
