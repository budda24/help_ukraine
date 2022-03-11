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
    return firebaseApp;
  }

  Future<void> loginExistingUser(String email, String password) async {
    try {
      final List loginMethods = await auth.fetchSignInMethodsForEmail(email);
      if (loginMethods.isEmpty) {
        Get.showSnackbar(customSnackbar(
            message: 'Email alredy exist', title: 'Error', icon: Icons.error));
      } else {
        final userData = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        print(userData.user!.uid);
      }
    } on FirebaseAuthException catch (error) {
      Get.showSnackbar(customSnackbar(
          message: 'logowanie nie powiodło z powodu $error',
          title: 'Error',
          icon: Icons.error));
    }
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
              message: 'This account exists with different sign in provider',
              icon: Icons.error,
              title: 'Error'));
          globalController.toogleIsLoading(); //switch to false
          Get.offAllNamed(Routes.AUTH);
          /* .then((value) => Get.showSnackbar(customSnackbar('You signing out.'))) */;
        } else if (e.code == 'invalid-credential') {
          Get.showSnackbar(customSnackbar(
              message: 'Unknown error has occured',
              icon: Icons.error,
              title: 'Error'));
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
        await googleSignIn.signOut().then((value) => Get.showSnackbar(
            customSnackbar(
                message: 'You signing out.',
                icon: Icons.error,
                title: 'Error')));
      }
      //for webb
      /* await FirebaseAuth.instance.signOut(); */
    } catch (e) {
      Get.showSnackbar(customSnackbar(
          message: 'Error signing out. Try again.',
          icon: Icons.error,
          title: 'Error'));
    }
  }

  Future<void> signInWithFacebook() async {
    globalController.toogleIsLoading(); //switch to true
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
            message: 'This account exists with different sign in provider',
            icon: Icons.error,
            title: 'Error'));
        await Future.delayed(Duration(seconds: 1));
        globalController.toogleIsLoading(); //switch to false
        Get.offAllNamed(Routes.AUTH);
      } else if (e.code == 'invalid-credential') {
        Get.showSnackbar(customSnackbar(
            message: 'Unknown error has occured ',
            icon: Icons.error,
            title: 'Error'));
        globalController.toogleIsLoading(); //switch to false
      }
    } catch (e) {
      print(e);
    } /* finally {

    } */
  }
}
