// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? email;

  @HiveField(2)
  String? gender;

  @HiveField(3)
  int? age;

  @HiveField(4)
  int? weight;

  @HiveField(5)
  int? height;

  @HiveField(6)
  List<String>? goals;

  @HiveField(7)
  String? level;

  @HiveField(8)
  String? picture;

  @HiveField(9)
  String? name;

  @HiveField(10)
  String? phone;

  @HiveField(11)
  bool? isFilled;

  UserModel({
    this.id,
    this.email,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.goals,
    this.level,
    this.picture,
    this.name,
    this.phone,
    this.isFilled,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    email: json["email"],
    gender: json["gender"],
    age: json["age"],
    weight: json["weight"],
    height: json["height"],
    goals: json["goals"] == null ? [] : List<String>.from(json["goals"]!.map((x) => x)),
    level: json["level"],
    picture: json["picture"],
    name: json["name"],
    phone: json["phone"],
    isFilled: json["is_filled"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "gender": gender,
    "age": age,
    "weight": weight,
    "height": height,
    "goals": goals == null ? [] : List<dynamic>.from(goals!.map((x) => x)),
    "level": level,
    "picture": picture,
    "name": name,
    "phone": phone,
    "is_filled": isFilled,
  };
}
