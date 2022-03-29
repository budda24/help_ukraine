

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';


import 'package:pomoc_ukrainie/app/globals/global_controler.dart';
import 'package:pomoc_ukrainie/app/infrastructure/fb_services/db_services/firebase.dart';
import 'package:pomoc_ukrainie/app/routes/app_pages.dart';
import 'package:pomoc_ukrainie/helpers/theme/alert_styles.dart';

import '../models/user.dart';

final auth = FirebaseAuth.instance;
User? user;

class Auth {
  final globalController = Get.put(GlobalController());

  Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
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

          var createdAt = FieldValue.serverTimestamp();
          await FirebaseFirestore.instance
              .collection('USERS')
              .where('UserDbId', isEqualTo: user!.uid)
              .get()
              .then((snapshot) async {
            if (snapshot.docs.isEmpty) {
              DbFirebase().createUser(
                UserDb(
                    id: user!.uid,
                    name: user!.displayName ?? 'no name',
                    photoUrl: user!.photoURL ?? 'no photo',
                    createdAt: createdAt),
              );
            }
          });

          globalController.box.remove(user!.uid );


        globalController.toogleIsLoading();
        //switch to false
        Get.offAndToNamed(Routes.PROFIL);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          await googleSignIn.signOut();

          await Get.showSnackbar(customSnackbar(
              //This account exists with different sign in provider
              message: 'Цей обліковий запис існує з іншим постачальником входу',
              icon: Icons.error,
              title: 'Помилка'));

          globalController.toogleIsLoading(); //switch to false

          Get.offAllNamed(Routes.AUTH);
        } else if (e.code == 'invalid-credential') {
          await Get.showSnackbar(customSnackbar(
              message: 'Сталася невідома помилка',
              icon: Icons.error,
              title: 'Помилка'));

          globalController.toogleIsLoading();
          //switch to false
          Get.offAllNamed(Routes.AUTH);
        }
      } catch (e) {
        await Get.showSnackbar(customSnackbar(
            message: 'Сталася невідома помилка',
            icon: Icons.error,
            title: 'Помилка'));
      }
    }
  }

/*   static Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!GetPlatform.isWeb) {
        await googleSignIn.signOut().then((value) => Get.showSnackbar(
            customSnackbar(
              //You signing out.
                message: 'Ви виходите.',
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
  } */

  Future<void> signInWithFacebook() async {
    globalController.toogleIsLoading(); //switch to true
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      final AuthCredential facebookCredential =
          FacebookAuthProvider.credential(result.accessToken!.token);

      final userCredential =
          await auth.signInWithCredential(facebookCredential);

      user = userCredential.user;

      Get.offNamed(Routes.PROFIL);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        await FacebookAuth.instance.logOut();

        await Get.showSnackbar(customSnackbar(
            //This account exists with different sign in provider
            message: 'Цей обліковий запис існує з іншим постачальником входу',
            icon: Icons.error,
            title: 'Помилка'));

        globalController.toogleIsLoading(); //switch to false
        Get.offAllNamed(Routes.AUTH);
      } else if (e.code == 'invalid-credential') {
        await Get.showSnackbar(customSnackbar(
            message: 'Сталася невідома помилка',
            icon: Icons.error,
            title: 'Помилка'));

        globalController.toogleIsLoading(); //switch to false
      }
    } catch (e) {
      await Get.showSnackbar(customSnackbar(
          message: 'Сталася невідома помилка',
          icon: Icons.error,
          title: 'Помилка'));
    }
  }
}
