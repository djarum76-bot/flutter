class UserModel {
  final String? uid;
  final String? username;
  final String? email;

  UserModel({this.uid, this.username, this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      uid: json['uid'],
      username: json['username'],
      email: json['email']
  );

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'username': username,
    'email': email,
  };
}