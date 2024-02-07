import 'dart:convert';

Admin adminFromJson(String str) => Admin.fromJson(json.decode(str));
String adminToJson(Admin data) => json.encode(data.toJson());

class Admin {
  int? id;
  String username;
  String password;

  Admin({
    this.id,
    required this.username,
    required this.password,
  });

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        id: json["id"],
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
      };
}
