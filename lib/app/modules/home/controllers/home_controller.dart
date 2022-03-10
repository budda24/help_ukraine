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
import 'package:pomoc_ukrainie/app/infrastructure/fb_services/db_services/firebase.dart';

import '../../../../helpers/theme/alert_styles.dart';
import '../../../globals/global_controler.dart';
import '../../../infrastructure/fb_services/auth/auth.dart';
import '../../models/city.dart';
import '../../models/need.dart';

class HomeController extends GetxController {
  final globalController = Get.put(GlobalController());

  //TODO: Implement HomeController
  TextEditingController nameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController adressController = TextEditingController();

  /* TextEditingController needAdressController = TextEditingController(); */

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
      r"[a-zA-Zа-яА-Яє-їЄ-Ї0-9\s]*$",
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
      var position = await _getGeoLocationPosition();
      var need = Need(
          address: adressController.text,
          title: titleController.text,
          description: descriptionController.text,
          contact: contactNumberController.text,
          city: cityController.text,
          email: user!.email,
          lat: position.latitude,
          long: position.longitude,
          postedBy: user!.uid);
      try {
        await DbFirebase().createNeed(need, user);
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
        desiredAccuracy: LocationAccuracy.best);
  }

  Future<Position> GetAddressFromLatLong() async {
    var position = await _getGeoLocationPosition();

    if (position.latitude != null || position.altitude != null) {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude)
              .then((value) {
        return value;
      });
      Placemark place = placemarks[0];
      /* to write in the form field */
      adressController.text = '${place.street!} \n ${place.postalCode!}';
      update();
    }
    return position;
  }

  final count = 0.obs;
  @override
  void onInit() async {
    getCityToModel();
    adressController.text = 'adress is loading...';
    await GetAddressFromLatLong();
    /* globalController.toogleIsLoading();
    print('on ${globalController.isLoading}'); */

    super.onInit();
  }

  @override
  void onReady() async {
    /*  globalController.toogleIsLoading();
    print('off ${globalController.isLoading}'); */
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
