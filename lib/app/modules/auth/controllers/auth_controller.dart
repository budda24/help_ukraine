import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pomoc_ukrainie/app/globals/global_controler.dart';

import '../../../infrastructure/fb_services/auth/auth.dart';

class AuthController extends GetxController {
  var globalController = Get.put(GlobalController());

  var auth = Auth();
  bool isLoading = false;

  void toogleIsLoading() {
    isLoading = !isLoading;
    update();
  }

  final count = 0.obs;
  @override
  void onInit() {
    globalController.unFocuseNode();
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
