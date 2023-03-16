import 'dart:convert';

class UserModel {
  UserModel({
    required this.id,
    required this.user,
    required this.password,
  });

  int id;
  String user;
  String password;

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        user: json["user"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user": user,
        "password": password,
      };
}
