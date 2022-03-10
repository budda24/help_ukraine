// To parse this JSON data, do
//
//     final need = needFromJson(jsonString);

// To parse this JSON data, do
//
//     final need = needFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../infrastructure/translate_sevices/google_cloud_trans.dart';

Need needFromJson(String str) => Need.fromJson(json.decode(str));

String needToJson(Need data) => json.encode(data.toJson());

class Need {
  Need({
    this.contact,
    required this.title,
    required this.description,
    this.createdAt,
    this.email,
    this.lat,
    this.long,
    this.postedBy,
    required this.address,
    this.city,
    this.id,
  });

  String title;
  String? city;
  String description;
  DateTime? createdAt;
  String? email;
  double? lat;
  double? long;
  String? postedBy;
  String address;
  String? contact;
  String? id;

  factory Need.fromJson(Map<String, dynamic> json) => Need(
        contact: json["contact"],
        title: json["title"],
        description: json["description"],
        createdAt: json["createdAt"].toDate(),
        email: json["email"],
        lat: json["lat"].toDouble(),
        long: json["long"].toDouble(),
        postedBy: json["postedBy"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "createdAt": Timestamp.fromDate(createdAt!),
        "email": email,
        "contact": contact,
        "lat": lat,
        "long": long,
        "postedBy": postedBy,
        "address": address,
      };

  translateToPL() async {
    this.email =
        await TranslationServices.translate(text: this.email!, language: 'pl');
    this.description = await TranslationServices.translate(
        text: this.description, language: 'pl');
    this.title =
        await TranslationServices.translate(text: this.title, language: 'pl');
    this.address =
        await TranslationServices.translate(text: this.address, language: 'pl');
  }
}
