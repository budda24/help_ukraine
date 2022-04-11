
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:get/get.dart';

import 'package:pomoc_ukrainie/app/globals/global_controler.dart';
import 'package:pomoc_ukrainie/app/infrastructure/fb_services/db_services/firebase.dart';
import 'package:pomoc_ukrainie/app/routes/app_pages.dart';
import 'package:pomoc_ukrainie/helpers/theme/alert_styles.dart';


final auth = FirebaseAuth.instance;
User? user;

class Auth {
  final globalController = Get.put(GlobalController());
  final db = DbFirebase();

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
        /* globalController.box.remove(user!.uid); */
        await db.createUser(user!);

        globalController.toogleIsLoading(); //switch to false

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

  Future<void> signUpEmailPassword(String email, String password) async {
    try {
      globalController.toogleIsLoading(); //switch to true


      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user != null) {
        user = userCredential.user;

        await db.createUser(user!);
      }
      globalController.toogleIsLoading(); //switch to false
      Get.offAndToNamed(Routes.PROFIL);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        globalController.toogleIsLoading(); //switch to false
        Get.showSnackbar(customSnackbar(
          message: 'Обліковий запис для цієї електронної пошти вже існує.',
          title: 'Помилка',
          icon: Icons.error,
        ));
      }
    } catch (e) {
      print(e);
    }
  }



  Future<void> signInExistingUser(String email, String password) async {
    try {
      globalController.toogleIsLoading(); //switch to true
      final List userEmails = await auth.fetchSignInMethodsForEmail(email);
      if (userEmails.isEmpty) {
        globalController.toogleIsLoading(); //switch to false
        Get.showSnackbar(customSnackbar(
          message: "ми не змогли знайти електронний лист",
          title: 'Помилка',
          icon: Icons.error,
        ));
      } else {
        final userData = await auth.signInWithEmailAndPassword(
            email: email, password: password);

            Get.offAndToNamed(Routes.PROFIL);

        globalController.toogleIsLoading(); //switch to false


      }
    } on FirebaseAuthException catch (error) {
      globalController.toogleIsLoading(); //switch to false
      Get.showSnackbar(customSnackbar(
        message: "Не вдалося ввійти, тому що ${error.message ?? ''}",
        title: 'Помилка',
        icon: Icons.error,
      ));
    }
  }

  Future<void> logOut() async {
   await auth.signOut();
   Get.offAndToNamed(Routes.AUTH);
  }

  Future<void> resetPasswordEmail(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (error) {
      Get.showSnackbar(customSnackbar(
        message: 'Не вдалося скинути пароль, тому що ${error.message}',
        title: 'Помилка',
        icon: Icons.error,
      ));
    }
  }
}





