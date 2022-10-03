// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.status,
    this.pesan,
    this.data,
  });

  int? status;
  String? pesan;
  Data? data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    status: json["status"],
    pesan: json["pesan"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "pesan": pesan,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.username,
    this.image,
    this.role,
  });

  int? id;
  String? username;
  Image? image;
  Image? role;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    username: json["username"],
    image: Image.fromJson(json["image"]),
    role: Image.fromJson(json["role"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "image": image!.toJson(),
    "role": role!.toJson(),
  };
}

class Image {
  Image({
    this.string,
    this.valid,
  });

  String? string;
  bool? valid;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    string: json["String"],
    valid: json["Valid"],
  );

  Map<String, dynamic> toJson() => {
    "String": string,
    "Valid": valid,
  };
}
