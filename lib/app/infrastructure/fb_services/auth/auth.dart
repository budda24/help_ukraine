import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:get/get.dart';
import 'package:pomoc_ukrainie/app/globals/global_controler.dart';
import 'package:pomoc_ukrainie/helpers/theme/alert_styles.dart';

final auth = FirebaseAuth.instance;

class Auth {
  final globalController = Get.find<GlobalController>();

  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    // TODO: Add auto login logic

    return firebaseApp;
  }

  static Future<User?> signInWithGoogle(
      /* {required BuildContext context} */) async {
    User? user;

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
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }

    return user;
  }

  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!GetPlatform.isWeb) {
        await googleSignIn.signOut();
      }
      //for webb
      /* await FirebaseAuth.instance.signOut(); */
    } catch (e) {
      Get.showSnackbar(customSnackbar('Error signing out. Try again.'));

      /* ScaffoldMessenger.of(context).showSnackBar(
        Authentication.customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      ); */
    }
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

