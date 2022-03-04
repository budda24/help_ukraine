import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocode/geocode.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
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
  TextEditingController needAdressController = TextEditingController();

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

  Future<void> postNeed() async {
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

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong() async {
    var position = await _getGeoLocationPosition();
    if (position.latitude != null || position.altitude != null) {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      /* print(placemarks); */
      Placemark place = placemarks[0];
      needAdressController.text = '${place.street!} \n ${place.postalCode!}';

      /* print(
        /* Mazowieckie, Warszawa, 20, 02-421, Księdza Juliana Chrościckiego 20 20  Księdza Juliana Chrościckiego */
          '${place.administrativeArea}, ${place.locality}, ${place.name}, ${place.postalCode}, ${place.street} ${place.subThoroughfare}  ${place.thoroughfare}');
    } */
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
