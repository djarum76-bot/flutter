// To parse this JSON data, do
//
//     final postsModel = postsModelFromJson(jsonString);

import 'dart:convert';

PostsModel postsModelFromJson(String str) => PostsModel.fromJson(json.decode(str));

String postsModelToJson(PostsModel data) => json.encode(data.toJson());

class PostsModel {
  PostsModel({
    this.status,
    this.data,
  });

  int? status;
  List<Datum>? data;

  factory PostsModel.fromJson(Map<String, dynamic> json) => PostsModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.userId,
    this.title,
    this.body,
  });

  int? id;
  int? userId;
  String? title;
  String? body;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "body": body,
  };
}
