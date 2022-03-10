import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:pomoc_ukrainie/app/modules/models/need.dart';
import '../../../../helpers/theme/alert_styles.dart';
import '../models/user.dart';

final db = FirebaseFirestore.instance;

class DbFirebase {
  Future<void> createUser(UserDb user) async {
    try {
      user.createdAt = FieldValue.serverTimestamp();
      await db.collection('user').doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      // Todo what to do in case that the auth user is created but the firestore user not
      Get.showSnackbar(customSnackbar("Account can't be created because $e"));
    }
  }

  Future<void> createUserNeed(Need need, User? user) async {
    await db
        .collection('user')
        .doc(user!.uid)
        .collection('needs')
        .doc()
        .set(need.toJson());
  }

  Future<void> createNeed(Need need, User? user) async {
    await need.translateToPL();
    try {
      need.createdAt = DateTime.now();
      //Todo how to get the Id created by firebase
      await createUserNeed(need, user);
      await db
          .collection('needs')
          .doc('pl')
          .collection(need.city!.toLowerCase())
          .doc()
          .set(need.toJson());
    } on FirebaseException catch (e) {
      Get.showSnackbar(customSnackbar("Need can't be created because $e"));
    } catch (e) {
      print('on db post $e');
    }
  }

  Future<List<Need>> feachNeedsInCity(String city) async {
    List<Need> needs = [];
    var response =
        await db.collection('needs').doc('pl').collection(city).get();
    /* var need = Need.fromJson(response.docs.first.data()); */
    response.docs.forEach((element) {
      needs.add(Need.fromJson(element.data()));
    });

    return needs;
  }
}
