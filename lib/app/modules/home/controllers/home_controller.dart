import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';

import 'package:get/get.dart';

import 'package:pomoc_ukrainie/app/infrastructure/fb_services/db_services/firebase.dart';

import '../../../../helpers/theme/alert_styles.dart';
import '../../../globals/global_controler.dart';
import '../../../infrastructure/fb_services/auth/auth.dart';
import '../../../infrastructure/fb_services/models/need.dart';
import '../../../infrastructure/geolocation_services/geolocation.dart';

class HomeController extends GetxController {
  TextEditingController adressController = TextEditingController();
  final adressFocusNode = FocusNode();
  TextEditingController cityController = TextEditingController();
  final cityFocusNode = FocusNode();
  TextEditingController contactNumberController = TextEditingController();
  final descripotionFocusNode = FocusNode();
  TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final globalController = Get.put(GlobalController());
  bool isPosition = false;
  //TODO: Implement HomeController
  TextEditingController nameController = TextEditingController();

  final nameFocusNode = FocusNode();
  RxList<Need> needs = <Need>[
    Need(
        uaDescription: 'uaDescription',
        uaTitle: 'uaTitle',
        city: 'city',
        title: 'title',
        description: 'description',
        contact: 'contact',
        lat: 0.2,
        long: 0.2,
        postedBy: 'postedBy',
        address: 'address'),
  ].obs;

  final phoneFocusNode = FocusNode();
  TextEditingController titleController = TextEditingController();
  final titleFocusNode = FocusNode();

  @override
  void onClose() {}

  @override
  void onInit() async {
    adressFocusNode.requestFocus();
    await getNeedsUser();
    update();

    adressController.text = 'adress is loading...';
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  void cleanController() {
    nameController.clear();
    contactNumberController.clear();
    cityController.clear();
    descriptionController.clear();
    titleController.clear();
    adressController.clear();
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
      globalController.toogleIsLoading();

      var position = await GelocationServices().getGeoLocationPosition();

      var need = Need(
          uaDescription: descriptionController.text,
          uaTitle: titleController.text,
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

  Future<void> getNeedsUser() async {
    needs.value = await DbFirebase().feachNeedsInUser(user!.uid);
    update();
  }

  Future<void> deleteNeed(String id, Need need) async {
    var db = DbFirebase();
    try {
      await db.deleteNeedUser(user!.uid, id);
      await db.deleteNeed(need);
      await db.deleteCityWhereNeed(need.city.toLowerCase());
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
    adressController.text =
        '${position.street!} \n${position.locality} ${position.postalCode!}';
    isPosition = true;
    update();
  }

  /* TextEditingController needAdressController = TextEditingController(); */
}
