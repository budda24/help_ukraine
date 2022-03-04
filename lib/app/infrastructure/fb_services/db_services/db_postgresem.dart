import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../modules/home/models/need.dart';
class DbPosgress{
Future<http.Response> createAlbum(Need need) {
  return http.post(
    Uri.parse('https://api.healthforukraine.pl/api/needs'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'needTitle':need.title,
      'needDescription':need.description,
      'contact':need.contact.toString(),
      'city':need.city,
      'email':need.email,
    }),
  );
}
}