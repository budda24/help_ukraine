import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../../../modules/models/need.dart';
import '../models/user.dart';

class DbPosgress {
  Future<http.Response> postNeed(Need need) {
    return http.post(
      Uri.parse('https://api.healthforukraine.pl/api/needs'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'needTitle': need.title,
        'needDescription': need.description,
        'contact': need.contact.toString(),
        'city': need.city,
        'email': need.email,
      }),
    );
  }

  Future<http.Response> postUser(User user) {
    String placeHOlderImg =
        'https://dsm01pap004files.storage.live.com/y4mgypsgKFZKRa2J_h8Pr_YhM9cgVuRrnKPDPlcgWHu7bnFpILw4WM2EH5DxUAXq2XYRgco8wragt5TrhY4NRLgWiwLarxTlKcLv39n13XF7_YIhV9-uGZHnrx7FfODM9Oozn5iNCnwZA1PTwM_wMgTrCsiYzfyqkHNJ0vOwtDaR0VXiyptkgbDjSNofQSLVgts?width=128&height=128&cropmode=none';
    var userDb = UserDb(
            id: user.uid,
            name: user.displayName ?? 'No Name',
            photoUrl: user.photoURL ?? placeHOlderImg)
        .toJson();

    return http.post(Uri.parse(''),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: userDb);
  }
}
