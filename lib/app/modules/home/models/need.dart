import 'dart:convert';

String cityToJson(Need data) => json.encode(data.toJson());

class Need {
  Need({
    required this.id,
    required this.needTitle,
    required this.contact,
    required this.city,
    required this.email,
  });

  String id;
  String needTitle;
  int contact;
  String city;
  String email;

  factory Need.fromJson(Map<String, dynamic> json) => Need(
        id: json["id"],
        needTitle: json["needTitle"],
        contact: json["contact"],
        city: json["city"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "needTitle": needTitle,
        "contact": contact,
        "city": city,
        "email": email,
      };
}
