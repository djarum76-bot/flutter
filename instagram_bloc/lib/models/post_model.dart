// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  PostModel({
    this.post,
    this.user,
  });

  Post? post;
  User? user;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    post: Post.fromJson(json["post"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "post": post!.toJson(),
    "user": user!.toJson(),
  };
}

class Post {
  Post({
    this.id,
    this.userId,
    this.image,
    this.caption,
    this.createdAt,
    this.likes,
  });

  int? id;
  int? userId;
  String? image;
  String? caption;
  DateTime? createdAt;
  List<Like>? likes;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    userId: json["user_id"],
    image: json["image"],
    caption: json["caption"],
    createdAt: DateTime.parse(json["createdAt"]),
    likes: List<Like>.from(json["likes"].map((x) => Like.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "image": image,
    "caption": caption,
    "createdAt": createdAt!.toIso8601String(),
    "likes": List<dynamic>.from(likes!.map((x) => x.toJson())),
  };
}

class Like {
  Like({
    this.id,
    this.postId,
    this.userId,
  });

  int? id;
  int? postId;
  int? userId;

  factory Like.fromJson(Map<String, dynamic> json) => Like(
    id: json["id"],
    postId: json["post_id"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "post_id": postId,
    "user_id": userId,
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
