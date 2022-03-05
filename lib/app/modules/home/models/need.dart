// To parse this JSON data, do
//
//     final need = needFromJson(jsonString);

import 'dart:convert';

import '../../../infrastructure/translate_sevices/google_cloud_trans.dart';

Need needFromJson(String str) => Need.fromJson(json.decode(str));

String needToJson(Need data) => json.encode(data.toJson());

class Need {
  Need({
    this.contact,
    this.id,
    required this.title,
    required this.description,
    this.createdAt,
    required this.email,
     this.status,
     this.lat,
     this.long,
    this.postedBy,
    this.updatedBy,
     this.address,
     this.urgency,
    required this.city,
  });

  String? id;
  String title;
  String description;
  String? createdAt;
  String? email;
  String? status;
  double? lat;
  double? long;
  String? postedBy;
  String? updatedBy;
  String? address;
  String? urgency;
  String city;
  int? contact;

  factory Need.fromJson(Map<String, dynamic> json) => Need(
        id: json["id"],
        contact: json["contact"],
        title: json["title"],
        description: json["description"],
        createdAt: json["createdAt"],
        email: json["email"],
        status: json["status"],
        lat: json["lat"].toDouble(),
        long: json["long"].toDouble(),
        postedBy: json["postedBy"],
        updatedBy: json["updatedBy"],
        address: json["address"],
        urgency: json["urgency"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "createdAt": createdAt,
        "email": email,
        "contact": contact,
        "lat": lat,
        "long": long,
        "postedBy": postedBy,
        "updatedBy": updatedBy,
        "address": address,
        "urgency": urgency,
        "city": city,
      };

  translateToUkrainian() async {
    this.city =
        await TranslationServices.translate(text: this.city, language: 'uk');
    this.email =
        await TranslationServices.translate(text: this.email!, language: 'uk');
    this.description = await TranslationServices.translate(
        text: this.description, language: 'uk');
    this.title =
        await TranslationServices.translate(text: this.title, language: 'uk');
    this.address =
        await TranslationServices.translate(text: this.address!, language: 'uk');
  }
}
