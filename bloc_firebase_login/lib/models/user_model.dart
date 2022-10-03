import 'package:bloc_firebase_login/utils/constants.dart';

class UserModel{
  final String? id;
  final String? name;

  UserModel({this.id, this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json[Constants.id],
    name: json[Constants.name],
  );

  Map<String, dynamic> toJson() => {
    Constants.id : id,
    Constants.name : name,
  };
}