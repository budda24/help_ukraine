import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserDb UserDbFromJson(String str) => UserDb.fromJson(json.decode(str));

String UserDbToJson(UserDb data) => json.encode(data.toJson());

class UserDb {
  UserDb({
    required this.id,
    required this.name,
    this.createdAt,
    required this.photoUrl,
    /* required this.number */
  });

  String id;
  String name;
  FieldValue? createdAt;
  String photoUrl;
  /* String number; */

  factory UserDb.fromJson(Map<String, dynamic> json) => UserDb(
        id: json["UserDbId"],
        name: json["name"],
        createdAt: json["createdAt"],
        photoUrl: json["photoUrl"],
        /* number: json["number"], */
      );

  Map<String, dynamic> toJson() => {
        "UserDbId": id,
        "name": name,
        "createdAt": createdAt,
        "photoUrl": photoUrl,
        /* "number": number, */
      };
}
