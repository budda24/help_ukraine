import 'dart:convert';

import '../../translate_sevices/google_cloud_trans.dart';

CityNeed cityNeedFromJson(String str, String cityName) =>
    CityNeed.fromJson(json.decode(str), cityName.toLowerCase());

String cityNeedToJson(CityNeed data, String cityName) =>
    json.encode(data.toJson(cityName.toLowerCase()));

class CityNeed {
  CityNeed({
    required this.needs,
  });

  Needs needs;

  factory CityNeed.fromJson(Map<String, dynamic> json, String cityName) =>
      CityNeed(
        needs: Needs.fromJson(json["needs"], cityName.toLowerCase()),
      );

  Map<String, dynamic> toJson(String cityName) => {
        "needs": needs.toJson(cityName.toLowerCase()),
      };
}

class Needs {
  Needs({
    required this.city,
  });

  List<Need> city;

  factory Needs.fromJson(Map<String, dynamic> json, String cityName) => Needs(
        city: List<Need>.from(json[cityName].map((x) => Need.fromJson(x))),
      );

  Map<String, dynamic> toJson(String cityName) => {
        cityName.toLowerCase(): List<dynamic>.from(city.map((x) => x.toJson())),
      };
}

class Need {
  Need({
    required this.uaDescription,
    required this.uaTitle,
    this.id,
    required this.city,
    required this.title,
    required this.description,
    this.createdAt,
    this.email,
    required this.contact,
    required this.lat,
    required this.long,
    required this.postedBy,
    required this.address,
  });

  String uaDescription;
  String uaTitle;
  String? id;
  String city;
  String title;
  String description;
  DateTime? createdAt;
  String? email;
  String contact;
  double lat;
  double long;
  String postedBy;
  String address;

  factory Need.fromJson(Map<String, dynamic> json) => Need(
        uaDescription: json["uaDescription"],
        uaTitle: json["uaTitle"],
        id: json["id"],
        city: json["city"],
        title: json["title"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        email: json["email"],
        contact: json["contact"],
        lat: json["lat"],
        long: json["long"],
        postedBy: json["postedBy"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "uaDescription": uaDescription,
        "uaTitle": uaTitle,
        "id": id,
        "city": city,
        "title": title,
        "description": description,
        "createdAt": createdAt!.toIso8601String(),
        "email": email,
        "contact": contact,
        "lat": lat,
        "long": long,
        "postedBy": postedBy,
        "address": address,
      };
        translateToPL() async {
    this.description = await TranslationServices.translate(
        text: this.description, language: 'pl');
    this.title =
        await TranslationServices.translate(text: this.title, language: 'pl');
  }
}
