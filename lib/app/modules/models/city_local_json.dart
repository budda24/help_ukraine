import 'dart:convert';

City cityFromJson(String str) => City.fromJson(json.decode(str));

String cityToJson(City data) => json.encode(data.toJson());

class City {
    City({
       required this.id,
       required this.name,
    });

    String id;
    String name;

    factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["text_simple"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}