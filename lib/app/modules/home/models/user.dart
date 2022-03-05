import 'dart:convert';

User UserFromJson(String str) => User.fromJson(json.decode(str));

String UserToJson(User data) => json.encode(data.toJson());

class User {
    User({
       required this.userId,
       required this.name,
       required this.createdAt,
       required this.photoUrl,
    });

    String userId;
    String name;
    String createdAt;
    String photoUrl;

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        name: json["name"],
        createdAt: json["createdAt"],
        photoUrl: json["photoUrl"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "createdAt": createdAt,
        "photoUrl": photoUrl,
    };
}