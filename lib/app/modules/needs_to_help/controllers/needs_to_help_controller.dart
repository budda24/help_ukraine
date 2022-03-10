import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pomoc_ukrainie/app/modules/models/need.dart';
import 'package:pomoc_ukrainie/helpers/widgets/online_tribes/row_progress_dott.dart';

import '../../../infrastructure/fb_services/db_services/firebase.dart';

class NeedsToHelpController extends GetxController {
  TextEditingController cityController = TextEditingController();

  RxList<Need> needs =<Need> [].obs;
  Future<void> getNeedsCity(String city) async {
     needs.value = await DbFirebase().feachNeedsInCity(city);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
