import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pomoc_ukrainie/app/modules/models/city_local_json.dart';

import 'package:pomoc_ukrainie/app/modules/models/need.dart';
import '../../../../helpers/theme/alert_styles.dart';
import '../auth/auth.dart';
import '../models/user.dart';
import '../models/city_with_needs.dart';

final db = FirebaseFirestore.instance;

class DbFirebase {
  Future<void> createUser(UserDb user) async {
    try {
      user.createdAt = FieldValue.serverTimestamp();
      await db.collection('user').doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      // Todo what to do in case that the auth user is created but the firestore user not
      Get.showSnackbar(customSnackbar(
          message: "Account can't be created because $e",
          icon: Icons.error,
          title: 'Error'));
    }
  }

  Future<void> createUserNeed(Need need, User? user) async {
    var json = need.toJson();
    /* json.addAll({'doNeedExist': true}); */
    await db
        .collection('user')
        .doc(user!.uid)
        .collection('needs')
        .doc()
        .set(json);
  }

  Future<void> createCityWithNeeds(String city) async {
    try {
      int quantity = 1;
      Map<String, dynamic> json;
      List<CityWithNeeds> existingCity = await feachCityWhereNeeds();
      if (existingCity.any((element) => element.name == city)) {
        CityWithNeeds? foundCity =
            existingCity.firstWhere((element) => element.name == city);

        quantity = int.parse(foundCity.quantity);
        quantity++;
        print('foundcity: $foundCity');
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
      print(error);
    } catch (error) {
      print(error);
    }
  }

  Future<void> createNeed(Need need, User? user) async {
    need.createdAt = DateTime.now();
    need.id = user!.uid;
    try {
      //Todo how to get the Id created by firebase

      /* await need.translateToPL(); */

      var response = await db
          .collection('needs')
          .doc('pl')
          .collection(need.city!.toLowerCase())
          .doc(user.uid)
          .set(need.toJson());

      await createCityWithNeeds(need.city ?? '');
      await createUserNeed(need, user);
    } on FirebaseException catch (e) {
      Get.showSnackbar(customSnackbar(
          message: "Need can't be created because $e",
          icon: Icons.error,
          title: 'Error'));
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

  Future<List<Need>> feachNeedsInUser(String id) async {
    /* print('feachNeedsInUser'); */
    List<Need> needs = [];
    var response =
        await db.collection('user').doc(id).collection('needs').get();
    /* var need = Need.fromJson(response.docs.first.data()); */

    response.docs.forEach((element) {
      var need = Need.fromJson(element.data());
      need.id = element.id;
      needs.add(need);
    });

    return needs;
  }

  Future<List<CityWithNeeds>> feachCityWhereNeeds() async {
    List<CityWithNeeds> cityWithNeeds = [];
    try {
      var response = await db.collection('citiesWithNeed').get();
      response.docs.forEach((element) {
        CityWithNeeds tmpCity = CityWithNeeds.fromJson(element.data());
        tmpCity.id = element.reference.id;
        cityWithNeeds.add(tmpCity);
      });
    } catch (error) {
      print(error);
    }
    return cityWithNeeds;
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

  Future<void> deleteNeedUser(String userId, String docId) {
    return db
        .collection('user')
        .doc(userId)
        .collection('needs')
        .doc(docId)
        .delete();
  }

  Future<void> deleteNeed(Need need) async {
    await db
        .collection('needs')
        .doc('pl')
        .collection(need.city!.toLowerCase())
        .doc(user!.uid)
        .delete();
  }

  Future<void> deleteCityWhereNeed(String city) async {
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
  }
}
