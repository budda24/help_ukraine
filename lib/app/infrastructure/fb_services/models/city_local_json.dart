import 'dart:convert';

City cityFromJson(String str) => City.fromJson(json.decode(str));

String cityToJson(City data) => json.encode(data.toJson());

class City {
  City({
    required this.id,
    required this.name,
    required this.quantity,
  });

  int id;
  String name;
  int quantity;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "quantity": quantity,
      };

 static Map<String, dynamic> listToJson(List<City> existingCities) {
    Map<String, dynamic> jsonCities = {};
    List<Map<String, dynamic>> listofjson = [];

    //creating Map of jsons
    existingCities.forEach(
      (element) {
        listofjson.add({
          "name": element.name,
          "id": element.id,
          "quantity": element.quantity
        });
      },
    );
    jsonCities.addAll({'cities': listofjson});
    return jsonCities;
  }
}
