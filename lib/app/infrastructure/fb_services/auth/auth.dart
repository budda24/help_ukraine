import 'dart:io';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:pomoc_ukrainie/app/globals/global_controler.dart';
import 'package:pomoc_ukrainie/app/infrastructure/fb_services/db_services/db_postgresem.dart';
import 'package:pomoc_ukrainie/app/infrastructure/fb_services/db_services/firebase.dart';
import 'package:pomoc_ukrainie/app/routes/app_pages.dart';
import 'package:pomoc_ukrainie/helpers/theme/alert_styles.dart';

import '../models/user.dart';

final auth = FirebaseAuth.instance;
User? user;

class Auth {
  final globalController = Get.put(GlobalController());

  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    // TODO: Add auto login logic

    return firebaseApp;
  }

  Future<User?> signInWithGoogle() async {
    globalController.toogleIsLoading(); //switch to true
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

        /* globalController.box.write(response from db); */
        /* DbPosgress().postUser(user!); */

        DbFirebase().createUser(
          UserDb(
            id: user!.uid,
            name: user!.displayName ?? 'no name',
            photoUrl: user!.photoURL ?? 'no name',
          ),
        );

        // once you signin, you can pass email, userId to the api (Depends upon what parameters API developer is asking)
        // After that, in response you are going to get an API Token (Most probably JWT Token), store that token into GetStorage (Local Storage)
        // When you logout, clear that token
        // If token is null or empty, user is not logged in, and vice versa

        globalController.toogleIsLoading(); //switch to false
        Get.offNamed(Routes.HOME);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          await googleSignIn.signOut();
          Get.showSnackbar(customSnackbar(
              'This account exists with different sign in provider'));
          globalController.toogleIsLoading(); //switch to false
          Get.offAllNamed(Routes.AUTH);
          /* .then((value) => Get.showSnackbar(customSnackbar('You signing out.'))) */;
        } else if (e.code == 'invalid-credential') {
          Get.showSnackbar(customSnackbar('Unknown error has occured'));
          globalController.toogleIsLoading(); //switch to false
          Get.offAllNamed(Routes.AUTH);
        }
      } catch (e) {
        // handle the error here
      }
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

