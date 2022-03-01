import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:pomoc_ukrainie/app/globals/global_controler.dart';
import 'package:pomoc_ukrainie/helpers/theme/alert_styles.dart';

final auth = FirebaseAuth.instance;

class Auth {
  final globalController = Get.find<GlobalController>();

  Future<void> loginExistingUser(String email, String password) async {
    try {
      final List loginMethods = await auth.fetchSignInMethodsForEmail(email);
      if (loginMethods.isEmpty) {
        Get.showSnackbar(customSnackbar('Email alredy exist'));
      } else {
        final userData = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        print(userData.user!.uid);
      }
    } on FirebaseAuthException catch (error) {
      Get.showSnackbar(
          customSnackbar('logowanie nie powiodło z powodu $error'));
    }
  }

  Future<void> signInUser(String email, String password) async {
    try {
      
      final List loginMethods = await auth.fetchSignInMethodsForEmail(email);
      if (loginMethods.isEmpty) {
        Get.showSnackbar(customSnackbar('Email alredy exist'));
      } else {
        final userData = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        print(userData.user!.uid);
      }
    } on FirebaseAuthException catch (error) {
      Get.showSnackbar(
          customSnackbar('logowanie nie powiodło z powodu $error'));
    }
  }
}
