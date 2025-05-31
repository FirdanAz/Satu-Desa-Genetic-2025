// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';

LocationModel locationModelFromJson(String str) =>
    LocationModel.fromJson(json.decode(str));

String locationModelToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel {
  List<DatumLocation> data;
  Meta meta;

  LocationModel({
    required this.data,
    required this.meta,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        data: List<DatumLocation>.from(json["data"].map((x) => DatumLocation.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class DatumLocation {
  String code;
  String name;

  DatumLocation({
    required this.code,
    required this.name,
  });

  factory DatumLocation.fromJson(Map<String, dynamic> json) => DatumLocation(
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
      };
}

class Meta {
  int administrativeAreaLevel;
  DateTime updatedAt;

  Meta({
    required this.administrativeAreaLevel,
    required this.updatedAt,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        administrativeAreaLevel: json["administrative_area_level"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "administrative_area_level": administrativeAreaLevel,
        "updated_at": updatedAt.toIso8601String(),
      };
}
