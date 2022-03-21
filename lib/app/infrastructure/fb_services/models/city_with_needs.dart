// To parse this JSON data, do
//
//     final cityWithNeeds = cityWithNeedsFromJson(jsonString);

import 'dart:convert';

CityWithNeeds cityWithNeedsFromJson(String str) =>
    CityWithNeeds.fromJson(json.decode(str));

String cityWithNeedsToJson(CityWithNeeds data) => json.encode(data.toJson());

class CityWithNeeds {
  CityWithNeeds({
     this.id,
    required this.quantity,
    required this.name,
  });

  String quantity;
  String name;
  String? id;

  factory CityWithNeeds.fromJson(Map<String, dynamic> json) => CityWithNeeds(
        quantity: json["quantity"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "name": name,
      };
}

