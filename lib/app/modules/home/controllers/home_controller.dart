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
import '../../../infrastructure/geolocation_services/geolocation.dart';
import '../../../infrastructure/fb_services/models/city.dart';
import '../../../infrastructure/fb_services/models/need.dart';

class HomeController extends GetxController {
  final globalController = Get.put(GlobalController());

  final nameFocusNode = FocusNode();
  final titleFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final descripotionFocusNode = FocusNode();
  final adressFocusNode = FocusNode();
  final cityFocusNode = FocusNode();

  TextEditingController nameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController adressController = TextEditingController();

  ScrollController addNeedScrollController = ScrollController();

  void cleanController() {
    nameController.clear();
    contactNumberController.clear();
    cityController.clear();
    descriptionController.clear();
    titleController.clear();
    adressController.clear();
  }

  /* TextEditingController needAdressController = TextEditingController(); */

  final formKey = GlobalKey<FormState>();

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

  /*  String findCityId(String city) {
    String idCity = '';

    polishCity.forEach((element) {
      if (city == element['name']) {
        idCity = element['id'];
      }
    });
    return idCity;
  } */

  Future<void> postNeed() async {
    if (validateForm()) {
      globalController.toogleIsLoading();
      String cityId = globalController.finCityId(cityController.text);

      var position = await GelocationServices().getGeoLocationPosition();

      var need = Need(
          cityId: cityId,
          uaDescription: descriptionController.text,
          uaTitle: titleController.text,
          address: adressController.text,
          title: titleController.text,
          description: descriptionController.text,
          contact: contactNumberController.text,
          city: cityController.text,
          email: auth.currentUser!.email,
          lat: position.latitude,
          long: position.longitude,
          postedBy: auth.currentUser!.uid);
      try {
        await DbFirebase().createNeed(need, auth.currentUser);
        cleanController();
        globalController.toogleIsLoading();
      } catch (e) {
        Get.showSnackbar(customSnackbar(
            message: 'надіслати потребу не вдалося, тому що: $e',
            icon: Icons.error,
            title: 'Помилка'));
      }
    }
  }

  RxList<Need> needs = <Need>[].obs;
  Future<void> getNeedsUser() async {
    needs.value = await DbFirebase().feachNeedsInUser(auth.currentUser!.uid);
    update();
  }

  Future<void> deleteNeed(String id, Need need) async {
    var db = DbFirebase();
    try {
      /* await db.deleteNeedUser(user!.uid, id); */
      await db.deleteNeed();
/*       await db.deleteCityWhereNeed(need.city ?? ''); */
      update();
      Get.showSnackbar(customSnackbar(
          message: 'видалено успішно',
          icon: Icons.file_download_done,
          title: 'зроблено'));
    } catch (e) {
      Get.showSnackbar(customSnackbar(
          message: 'видалено НЕ досягає успіх',
          icon: Icons.error,
          title: 'Помилка'));
    } finally {
      needs.removeWhere((element) => element.id == id);
    }
  }

  bool isPosition = false;

  void getPosition() async {
    Placemark position = await GelocationServices().GetAddressFromLatLong();
    adressController.text =
        '${position.street!} \n${position.locality} ${position.postalCode!}';
    isPosition = true;
    update();
  }

  @override
  void onInit() async {
    var need = Need(
      cityId: 'LZQGWcyWw2jPvcTNpt',
      uaDescription: 'descriptionController.text',
      uaTitle: 'titleController.text',
      address: 'adressController.text',
      title: 'titleController.text',
      description: 'descriptionController.text',
      contact: 'contactNumberController.tex',
      city: 'Warszawa',
      email: user!.email,
      lat: 100,
      long: 199,
      postedBy: user!.uid,
      createdAt: DateTime.now(),
    );
    /* for (var i = 0; i < 20; i++) {
      Future.delayed(Duration(seconds: 1)).then((value) => DbFirebase().createNeed(need, user));

    } */
    adressFocusNode.requestFocus();
    await getNeedsUser();
    update();

    /* adressController.text = 'adress is loading...'; */
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {}
}
