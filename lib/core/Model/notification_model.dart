// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  final String? title;
  final String? body;
  final String? id;

  NotificationModel({
    this.id,
    this.title,
    this.body,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        title: json["title"],
        body: json["body"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "id": id,
      };
}
