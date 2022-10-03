// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

CommentModel commentModelFromJson(String str) => CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
  CommentModel({
    this.id,
    this.postId,
    this.userId,
    this.komen,
    this.createdAt,
    this.user,
  });

  int? id;
  int? postId;
  int? userId;
  String? komen;
  String? createdAt;
  User? user;

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
    id: json["id"],
    postId: json["post_id"],
    userId: json["user_id"],
    komen: json["komen"],
    createdAt: json["createdAt"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "post_id": postId,
    "user_id": userId,
    "komen": komen,
    "createdAt": createdAt,
    "user": user!.toJson(),
  };
}

class User {
  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
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
