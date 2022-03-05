import 'dart:convert';

UserDb UserDbFromJson(String str) => UserDb.fromJson(json.decode(str));

String UserDbToJson(UserDb data) => json.encode(data.toJson());

class UserDb {
  UserDb({
    required this.userId,
    required this.name,
     this.createdAt,
    required this.photoUrl,
  });

  String userId;
  String name;
  String? createdAt;
  String photoUrl;

  factory UserDb.fromJson(Map<String, dynamic> json) => UserDb(
        userId: json["UserDbId"],
        name: json["name"],
        createdAt: json["createdAt"],
        photoUrl: json["photoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "UserDbId": userId,
        "name": name,
        "createdAt": createdAt,
        "photoUrl": photoUrl,
      };
}
