import 'dart:convert';

import 'package:pomoc_ukrainie/app/infrastructure/translate_sevices/google_cloud_trans.dart';

Need needFromJson(String str) => Need.fromJson(json.decode(str));

String needToJson(Need data) => json.encode(data.toJson());

class Need {
  Need({
    required this.title,
    required this.description,
    required this.contact,
    required this.city,
    required this.email,
  });

  String title;
  String description;
  int contact;
  String city;
  String email;

  factory Need.fromJson(Map<String, dynamic> json) => Need(
        title: json["needTitle"],
        description: json["needDescription"],
        contact: json["contact"],
        city: json["city"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "needTitle": title,
        "needDescription": description,
        "contact": contact,
        "city": city,
        "email": email,
      };

  translateUkrainian() async{
    this.city = await TranslationServices.translate(text: this.city, language: 'uk');
    this.email = await TranslationServices.translate(text: this.email, language: 'uk');
    this.description = await TranslationServices.translate(text: this.description, language: 'uk');
    this.title = await TranslationServices.translate(text: this.title, language: 'uk');
}
}
