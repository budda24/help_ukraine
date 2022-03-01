import 'dart:convert';

import 'package:http/http.dart' as http;
class DbPosgress{
Future<http.Response> createAlbum() {
  return http.post(
    Uri.parse('http://api.healthforukraine.pl/api/needs'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      /* 'id':'testId',
      'needTitle': 'title',
      'needDescription':'test need decription',
      'contact':'123432234',
      'city':'Warszawa',
      'email':'test@test.com',
      'createdAt':DateTime.now().toString(),
      'updatedAt':DateTime.now().toString(), */

    }),
  );
}
}