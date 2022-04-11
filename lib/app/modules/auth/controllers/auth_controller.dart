import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomoc_ukrainie/app/globals/global_controler.dart';

import '../../../../helpers/theme/alert_styles.dart';
import '../../../infrastructure/fb_services/auth/auth.dart';
import '../../../routes/app_pages.dart';

enum AuthMode { Login, Signup }

class AuthController extends GetxController {
  var globalController = Get.put(GlobalController());
  var auth = Auth();

  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController resetPassEmailController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool validateSigninForm({
    required TextEditingController emailContr,
    required TextEditingController passwordContr,
  }) {
    if (!GetUtils.isEmail(emailContr.text)) {
      /* print('email : ${email.text}'); */
      emailContr.clear();
      Get.showSnackbar(
        customSnackbar(
            message: 'Email is Invalid', title: 'Error', icon: Icons.error),
      );
      return false;
    }

    if (!GetUtils.isLengthGreaterThan(passwordContr.text, 8)) {
      Get.showSnackbar(
        customSnackbar(
            message: 'Password should contain from 8 to 16 characters',
            title: 'Error',
            icon: Icons.error),
      );
      passwordContr.clear();
      return false;
    }
/* minimum eight characters, at least one letter and one number */
    RegExp regExpPassword = RegExp(
      r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$",
      caseSensitive: false,
      multiLine: false,
    );
    if (!regExpPassword.hasMatch(passwordContr.text)) {
      Get.showSnackbar(customSnackbar(
        message: 'Password should contain at least one letter and one number',
        title: 'Error',
        icon: Icons.error,
      ));

      passwordContr.clear();
      return false;
    } else {
      return true;
    }
  }

  AuthMode authMode = AuthMode.Login;
  void switchAuthMode() {
    authMode = authMode == AuthMode.Login ? AuthMode.Signup : AuthMode.Login;
    update();
  }

  Future<void> signUp() async {
    if (validateSigninForm(
        emailContr: emailController, passwordContr: passwordController)) {
      print('signup');
      await auth
          .signUpEmailPassword(emailController.text, passwordController.text)
          .catchError((onError) {
        print(onError);
      });
    }
  }

  Future<void> signIn() async {
    if (validateSigninForm(
        emailContr: emailController, passwordContr: passwordController)) {
      await auth.signInExistingUser(
          emailController.text, passwordController.text);
      /* emailController.clear();
      passwordController.clear(); */
      
    }
  }

/*
  Future<bool> checkLogIn() async {

    } */

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
