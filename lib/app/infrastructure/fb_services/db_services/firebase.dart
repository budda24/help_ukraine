import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomoc_ukrainie/app/infrastructure/fb_services/models/city_local_json.dart';
import 'package:pomoc_ukrainie/app/infrastructure/fb_services/models/need.dart';

import '../../../../helpers/theme/alert_styles.dart';
import '../auth/auth.dart';
import '../models/user.dart';

final db = FirebaseFirestore.instance;

class DbFirebase {
  Future<void> createUser(UserDb user) async {
    try {
      user.createdAt = FieldValue.serverTimestamp();
      await db.collection('user').doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      Get.showSnackbar(customSnackbar(
          message: "Account can't be created because $e",
          icon: Icons.error,
          title: 'Error'));
    }
  }

  void fetchNeedsDocument() {
    var response = db.collection('needs').doc('postedNeeds');
  }

  Future<void> createNeed(Need need, User? user) async {
    need.createdAt = DateTime.now();
    need.id = user!.uid;

    try {
      await createUserNeed(need, user);

      await need.translateToPL();
      var fechedNeedsDocument = await feachNeedsDoc();
      List<Need> needs = [];
      String city = need.city.toLowerCase();

      if (fechedNeedsDocument.exists) {
        Map<String, dynamic> needsDocument =
            fechedNeedsDocument.data()!['needs'] as Map<String, dynamic>;
        List<dynamic> needs = needsDocument[city] ?? [];

        needs.add(need.toJson());
        needsDocument.addAll({city: needs}); //update map with key city
        needsDocument = {'needs': needsDocument};
        var response =
            await db.collection('needs').doc('postedNeeds').set(needsDocument);
      }
      await addCityWithNeed(need.city);
    } on FirebaseException catch (error) {
      await Get.showSnackbar(customSnackbar(
          message: "Need can't be created because $error",
          icon: Icons.error,
          title: 'Error'));
    } catch (error) {
      print('on db post $error');
    }
  }

  Future<void> createUserNeed(Need need, User? user) async {
    var json = need.toJson();

    await db
        .collection('user')
        .doc(user!.uid)
        .collection('needs')
        .doc()
        .set(json);
  }

  Future<void> addCityWithNeed(String city) async {
    try {
      List<City> existingCities = await getCities();
      int foundCityIndex =
          existingCities.indexWhere((element) => element.name == city);

      existingCities[foundCityIndex].quantity++;

      Map<String, dynamic> jsonCities = City.listToJson(existingCities);
      await db.collection('polishCities').doc('cities').set(jsonCities);
    } on FirebaseException catch (error) {
      await Get.showSnackbar(customSnackbar(
          message: "Need can't be created because $error",
          icon: Icons.error,
          title: 'Error'));
    } catch (error) {
      print(error);
    }
  }

/*   Future<void> createJsonCity(Map<String, dynamic> map) async {
    var body = jsonEncode(map);
    var response = await db.collection('polishCities').doc('cities').set(map);
  } */

  Future<DocumentSnapshot<Map<String, dynamic>>> feachNeedsDoc() async {
    var response = await db.collection('needs').doc('postedNeeds').get();

    return response;
  }

  Future<List<Need>> feachNeedsInCity(String city) async {
    var fechedNeedsDocument = await feachNeedsDoc();

    List<Need> needs = [];

    if (fechedNeedsDocument.exists) {
      Map<String, dynamic> needsDocument =
          fechedNeedsDocument.data()!['needs'] as Map<String, dynamic>;
      List<dynamic> needsMap = needsDocument[city] ?? [];
      needs = needsMap.map((e) => Need.fromJson(e)).toList();
    }
    return needs;
  }

  Future<List<Need>> feachNeedsInUser(String id) async {
    List<Need> needs = [];
    var response =
        await db.collection('user').doc(id).collection('needs').get();
    response.docs.forEach((element) {
      var need = Need.fromJson(element.data());
      need.id = element.id;
      needs.add(need);
    });

    return needs;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fechCities() async {
    var response = await db.collection('polishCities').get();
    return response;
  }

  Future<List<City>> getCities() async {
    List<City> cities = [];
    try {
      var response = await fechCities();
      List<dynamic> citiesJson = response.docs.first['cities'];
      for (var i = 0; i < 100; i++) {
        City city = City.fromJson(citiesJson[i]);
        cities.add(city);
      }
    } catch (e) {
      print(e);
    }
    return cities;
  }

  Future<List<City>> getCityWhereNeeds() async {
    List<City> cities = await getCities();
    List<City> citiesWithNeeds = [];
    try {
      for (var i = 0; i < 100; i++) {
        City city = cities[i];
        citiesWithNeeds.addIf(city.quantity != 0, city);
      }
    } catch (error) {
      print(error);
    }
    return citiesWithNeeds;
  }

/*   Future<List<City>> feachCitiesWhereNeeds(String id) async {
    /* print('feachNeedsInUser'); */
    List<City> cities = [];

    var response = await db.collection('citiesWithNeed').get();
    print('lenght cities ${response.docs.length}');

    cities =
        response.docs.map((e) => City.fromJson(e.data())).toList();

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
    var fechedNeedsDocument = await feachNeedsDoc();
    var cityNeed = need.city.toLowerCase();
    Map<String, dynamic> needsDocument =
        fechedNeedsDocument.data()!['needs'] as Map<String, dynamic>;
    List<dynamic> needs = needsDocument[cityNeed] ?? [];

    needs.removeWhere((value) => value['postedBy'] == need.postedBy);
    needsDocument.addAll({cityNeed: needs}); //update map with key city
    needsDocument = {'needs': needsDocument};

    await db
        .collection('needs')
        .doc('postedNeeds')
        .set(needsDocument)
        .catchError((onError) => print(onError));
  }

  Future<void> deleteCityWhereNeed(String city) async {
    List<City> existingCities = await getCities();

    int indexDeletedCity = existingCities
        .indexWhere((element) => element.name.toLowerCase() == city);

    existingCities[indexDeletedCity].quantity--;

    Map<String, dynamic> jsonCities = City.listToJson(existingCities);

    await db.collection('polishCities').doc('cities').set(jsonCities);
  }
}
