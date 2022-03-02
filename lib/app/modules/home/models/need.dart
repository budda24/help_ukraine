import 'dart:convert';

Need cityFromJson(String str) => Need.fromJson(json.decode(str));

String cityToJson(Need data) => json.encode(data.toJson());

class Need {
  Need({
    required this.needTitle,
    required this.needDescription,
    required this.contact,
    required this.city,
    required this.email,
  });

  String needTitle;
  String needDescription;
  int contact;
  String city;
  String email;

  factory Need.fromJson(Map<String, dynamic> json) => Need(
        needTitle: json["needTitle"],
        needDescription: json["needDescription"],
        contact: json["contact"],
        city: json["city"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "needTitle": needTitle,
        "needDescription": needDescription,
        "contact": contact,
        "city": city,
        "email": email,
      };
}
