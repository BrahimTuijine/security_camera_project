// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

SensorModel sensorModelFromJson(String str) =>
    SensorModel.fromJson(json.decode(str));

String sensorModelToJson(SensorModel data) => json.encode(data.toJson());

class SensorModel {
  final String? sensorType;
  final String? refrences;
  final String? measuringRange;
  final String? sustainability;
  final String? id;

  SensorModel({
    this.sensorType,
    this.refrences,
    this.measuringRange,
    this.sustainability,
    this.id,
  });

  factory SensorModel.fromJson(Map<String, dynamic> json) => SensorModel(
        sensorType: json["sensorType"],
        refrences: json["refrences"],
        measuringRange: json["measuringRange"],
        sustainability: json["sustainability"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "sensorType": sensorType,
        "refrences": refrences,
        "measuringRange": measuringRange,
        "sustainability": sustainability,
        "id": id,
      };
}
