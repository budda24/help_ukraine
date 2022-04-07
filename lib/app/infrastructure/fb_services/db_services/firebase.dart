import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomoc_ukrainie/app/globals/global_controler.dart';

import 'package:pomoc_ukrainie/app/infrastructure/fb_services/models/need.dart';
import '../../../../helpers/theme/alert_styles.dart';
import '../auth/auth.dart';
import '../models/user.dart';

final db = FirebaseFirestore.instance;

class DbFirebase {
  var globalController = Get.put(GlobalController());
  Future<void> createUser(UserDb user) async {
    try {
      user.createdAt = FieldValue.serverTimestamp();
      await db.collection('USERS').doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      Get.showSnackbar(customSnackbar(
          message: "Сталася помилка, спробуйте пізніше",
          icon: Icons.error,
          title: 'Помилка'));
    }
  }

  Future<void> createNeed(Need need, User? user) async {
    need.createdAt = DateTime.now();
    need.id = user!.uid;

    try {
      await need.translateToPL();
      var response = await db.collection('NEEDS').add(need.toJson());
    } on FirebaseException catch (_) {
      Get.showSnackbar(customSnackbar(
          message: 'Сталася помилка, спробуйте пізніше',
          icon: Icons.error,
          title: 'Помилка'));
    } catch (error) {
      print(error);
    }
  }

  Future<Query<Map<String, dynamic>>> feachNeedsInCity(
      String city, int limit) async {
    var response = await db
        .collection('NEEDS')
        .where('city', isEqualTo: city)
        .limit(limit);
    return response;
  }

  Future<List<Need>> feachNeedsInUser(String id) async {

    List<Need> needs = [];
    var response =
        await db.collection('NEEDS').where('postedBy', isEqualTo: id).get();
    response.docs.forEach((element) {
      var need = Need.fromJson(element.data());
      need.id = element.id;
      needs.add(need);
    });

    return needs;
  }

  Future<Map<String, dynamic>> feachCityStats() async {
    Map<String, dynamic> statsCity = {};
    try {
      var response = await db.collection('STATS').doc('CITY').get();
      if (response.exists) {
        statsCity = response.data()!;
      }
    } catch (error) {
      print(error);
    }
    return statsCity;
  }

  Future<void> deleteNeed() async {
    var userNeeds = db.collection("NEEDS").where('id', isEqualTo: user!.uid);
    userNeeds.get().then((value) => value.docs.forEach((element) {
          element.reference.delete();
        }));
  }

  
}
