// To parse this JSON data, do
//
//     final savedUser = savedUserFromJson(jsonString);

import 'dart:convert';

SavedUser savedUserFromJson(String str) => SavedUser.fromJson(json.decode(str));

String savedUserToJson(SavedUser data) => json.encode(data.toJson());

class SavedUser {
    final String? email;
    final String? password;
    final int? type;

    SavedUser({
        this.email,
        this.password,
        this.type,
    });

    factory SavedUser.fromJson(Map<String, dynamic> json) => SavedUser(
        email: json["email"],
        password: json["password"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "type": type,
    };
}
