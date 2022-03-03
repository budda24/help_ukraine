import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:get/get.dart';

import 'package:pomoc_ukrainie/app/globals/global_controler.dart';
import 'package:pomoc_ukrainie/app/routes/app_pages.dart';
import 'package:pomoc_ukrainie/helpers/theme/alert_styles.dart';

import 'third_party_status.dart';

final auth = FirebaseAuth.instance;
User? user;

class Auth {
  final globalController = Get.find<GlobalController>();

  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    // TODO: Add auto login logic

    return firebaseApp;
  }

  static Future<User?> signInWithGoogle(
      /* {required BuildContext context} */) async {
    /* User? user; */

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
            
        user = userCredential.user;
        Get.offNamed(Routes.HOME);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          await googleSignIn.signOut();
          Get.showSnackbar(customSnackbar(
              'This account exists with different sign in provider'));
          Get.offAllNamed(Routes.AUTH);
          /* .then((value) => Get.showSnackbar(customSnackbar('You signing out.'))) */;
        } else if (e.code == 'invalid-credential') {
          Get.showSnackbar(customSnackbar('Unknown error has occured'));
        }
      } catch (e) {
        // handle the error here
      } /* finally {

      } */
    }
  }

  static Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!GetPlatform.isWeb) {
        await googleSignIn.signOut().then(
            (value) => Get.showSnackbar(customSnackbar('You signing out.')));
      }
      //for webb
      /* await FirebaseAuth.instance.signOut(); */
    } catch (e) {
      Get.showSnackbar(customSnackbar('Error signing out. Try again.'));
    }
  }

  static Future<void> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      final AuthCredential facebookCredential =
          FacebookAuthProvider.credential(result.accessToken!.token);

      final userCredential =
          await auth.signInWithCredential(facebookCredential);

      user = userCredential.user;

      Get.offNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        await FacebookAuth.instance.logOut();
        Get.showSnackbar(customSnackbar(
            'This account exists with different sign in provider'));
        await Future.delayed(Duration(seconds: 1));
        Get.offAllNamed(Routes.AUTH);
      } else if (e.code == 'invalid-credential') {
        Get.showSnackbar(customSnackbar('Unknown error has occured'));
      }
    } catch (e) {
      print(e);
    } /* finally {

    } */
  }
}









































 /*  Future<void> loginExistingUser(String email, String password) async {
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
  } */

