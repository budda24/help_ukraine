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
import '../../models/city_local_json.dart';
import '../../models/need.dart';

class HomeController extends GetxController {
  final globalController = Get.put(GlobalController());

  final nameFocusNode = FocusNode();
  final titleFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final descripotionFocusNode = FocusNode();
  final adressFocusNode = FocusNode();
  final cityFocusNode = FocusNode();



  //TODO: Implement HomeController
  TextEditingController nameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController adressController = TextEditingController();

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

  Future<void> postNeed() async {
    if (validateForm()) {
        globalController.toogleIsLoading();

      var position = await GelocationServices().getGeoLocationPosition();
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
        cleanController();
        globalController.toogleIsLoading();
      } catch (e) {
        Get.showSnackbar(customSnackbar(
            message: 'надіслати потребу не вдалося, тому що: $e',
            icon: Icons.error,
            title: 'Error'));
      }
    }
  }

  RxList<Need> needs = <Need>[].obs;
  Future<void> getNeedsUser() async {
    needs.value = await DbFirebase().feachNeedsInUser(user!.uid);
    update();
  }

  Future<void> deleteNeed(String id, Need need) async {
    var db = DbFirebase();
    try {
      await db.deleteNeedUser(user!.uid, id);
      await db.deleteNeed(need);
      await db.deleteCityWhereNeed(need.city ?? '');
      update();
      Get.showSnackbar(customSnackbar(
          message: 'deleted succede',
          icon: Icons.file_download_done,
          title: 'Done'));
    } catch (e) {
      Get.showSnackbar(customSnackbar(
          message: 'deleted NOT succede becouse : $e',
          icon: Icons.error,
          title: 'Error'));
    } finally {
      needs.removeWhere((element) => element.id == id);
    }
  }

  void getPosition() async {
    Placemark position = await GelocationServices().GetAddressFromLatLong();
    adressController.text = '${position.street!} \n${position.locality} ${position.postalCode!}';
  }

  @override
  void onInit() async {
    adressFocusNode.requestFocus();
    await getNeedsUser();
    update();
    globalController.getCityToModel();
    adressController.text = 'adress is loading...';
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {}
}
