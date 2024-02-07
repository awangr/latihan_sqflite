import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toMap());

class UserModel {
  int? id;
  String username;
  String password;

  UserModel({
    this.id,
    required this.username,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "password": password,
      };
}
