// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? registerNumber;
  final String? poste;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.registerNumber,
    required this.poste,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        poste: json['poste'],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        id: json["id"],
        registerNumber: json['registerNumber'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "poste": poste,
        "registerNumber": registerNumber
      };
}
