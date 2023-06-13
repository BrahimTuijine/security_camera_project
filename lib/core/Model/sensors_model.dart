// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

SensorModel sensorModelFromJson(String str) =>
    SensorModel.fromJson(json.decode(str));

String sensorModelToJson(SensorModel data) => json.encode(data.toJson());

class SensorModel {
  final String? sensorType;
  final String? location;
  final String? isConnected;
  final String? id;

  SensorModel({
    this.sensorType,
    this.location,
    this.isConnected,
    this.id,
  });

  factory SensorModel.fromJson(Map<String, dynamic> json) => SensorModel(
        sensorType: json["sensorType"],
        location: json["location"],
        isConnected: json["isConnected"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "sensorType": sensorType,
        "location": location,
        "isConnected": isConnected,
        "id": id,
      };
}
