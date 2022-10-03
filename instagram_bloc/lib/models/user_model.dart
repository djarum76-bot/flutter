// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.id,
    this.username,
    this.email,
    this.phone,
    this.picture,
    this.createdAt,
  });

  int? id;
  String? username;
  String? email;
  Phone? phone;
  Phone? picture;
  String? createdAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    phone: Phone.fromJson(json["phone"]),
    picture: Phone.fromJson(json["picture"]),
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "phone": phone!.toJson(),
    "picture": picture!.toJson(),
    "createdAt": createdAt,
  };
}

class Phone {
  Phone({
    this.string,
    this.valid,
  });

  String? string;
  bool? valid;

  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
    string: json["String"],
    valid: json["Valid"],
  );

  Map<String, dynamic> toJson() => {
    "String": string,
    "Valid": valid,
  };
}
