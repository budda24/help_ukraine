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
          message: "Account can't be created because $e",
          icon: Icons.error,
          title: 'Error'));
    }
  }

  /* Future<void> createUserNeed(Need need, User? user) async {
    var json = need.toJson();

    await db
        .collection('USERS')
        .doc(user!.uid)
        .collection('needs')
        .doc()
        .set(json);
  } */

  Future<void> createNeed(Need need, User? user) async {
    need.createdAt = DateTime.now();
    need.id = user!.uid;

    try {
      /* await createUserNeed(need, user); */
      await need.translateToPL();
      var response = await db.collection('NEEDS').add(need.toJson());
    } on FirebaseException catch (error) {
      await Get.showSnackbar(customSnackbar(
          message: "Need can't be created because $error",
          icon: Icons.error,
          title: 'Error'));
    } catch (error) {
      print('on db post $error');
    }
  }

  Future<Query<Map<String, dynamic>>> feachNeedsInCity(
      String city, int limit) async {
    var response = await db
        .collection('NEEDS')
        .where('city', isEqualTo: city)
        .limit(limit);
    /* print(response); */
    return response;
  }

  Future<List<Need>> feachNeedsInUser(String id) async {
    print(id);
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

/*   Future<void> deleteNeedUser(String userId, String docId) {
    return db
        .collection('USERS')
        .doc(userId)
        .collection('needs')
        .doc(docId)
        .delete();
  } */

  Future<void> deleteNeed() async {
    var userNeeds = db.collection("NEEDS").where('id', isEqualTo: user!.uid);
    userNeeds.get().then((value) => value.docs.forEach((element) {
          print('delete need');
          element.reference.delete();
        }));
  }

  /*   Future<List<CityWithNeeds>> feachCitiesWhereNeeds(String id) async {
    /* print('feachNeedsInUser'); */
    List<CityWithNeeds> cities = [];

    var response = await db.collection('citiesWithNeed').get();
    print('lenght cities ${response.docs.length}');

    cities =
        response.docs.map((e) => CityWithNeeds.fromJson(e.data())).toList();

    return cities;
    /* var need = Need.fromJson(response.docs.first.data()); */
  } */

  /*  Future<void> deleteCityWhereNeed(String city) async {
    List<CityWithNeeds> cities = await feachCityWhereNeeds();
    CityWithNeeds deletedCity =
        cities.firstWhere((element) => element.name == city);

    int tmpQuantuty = int.parse(deletedCity.quantity) - 1;
    if (tmpQuantuty > 0) {
      deletedCity.quantity = tmpQuantuty.toString();
      await db
          .collection('citiesWithNeed')
          .doc(deletedCity.id)
          .set(deletedCity.toJson());
    } else
      await db.collection('citiesWithNeed').doc(deletedCity.id).delete();
  } */

/*   Future<void> createJsonCity(Map<String, dynamic> map) async {
    var body = jsonEncode(map);
    var response = await db.collection('POLISHCITIES').doc().set(map);
  }

  Future<void> createJsonStats(Map<String, dynamic> map) async {
    var body = jsonEncode(map);
    var response = await db.collection('STATS').doc('CITY').set(map);
  } */

  /*  Future<void> createCityWithNeeds(String city) async {
    try {
      int quantity = 1;
      Map<String, dynamic> json;

      List<CityWithNeeds> existingCities = await feachCityWhereNeeds();

      //check if existin cities connteins city wanted to post
      if (existingCities.any((element) => element.name == city)) {
        CityWithNeeds? foundCity =
            existingCities.firstWhere((element) => element.name == city);

        quantity = int.parse(foundCity.quantity);
        quantity++;
        json = CityWithNeeds(
          quantity: quantity.toString(),
          name: city,
          id: foundCity.id,
        ).toJson();

        await db.collection('citiesWithNeed').doc(foundCity.id).set(json);
      } else {
        json =
            CityWithNeeds(quantity: quantity.toString(), name: city).toJson();
        await db.collection('citiesWithNeed').add(json);
      }
    } on FirebaseException catch (error) {
      await Get.showSnackbar(customSnackbar(
          message: "Need can't be created because $error",
          icon: Icons.error,
          title: 'Error'));
    } catch (error) {
      print(error);
    }
  } */
}
