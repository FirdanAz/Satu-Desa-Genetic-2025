// To parse this JSON data, do
//
//     final districModel = districModelFromJson(jsonString);

import 'dart:convert';

DistricModel districModelFromJson(String str) => DistricModel.fromJson(json.decode(str));

String districModelToJson(DistricModel data) => json.encode(data.toJson());

class DistricModel {
    List<DatumVillage> data;
    Meta meta;

    DistricModel({
        required this.data,
        required this.meta,
    });

    factory DistricModel.fromJson(Map<String, dynamic> json) => DistricModel(
        data: List<DatumVillage>.from(json["data"].map((x) => DatumVillage.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
    };
}

class DatumVillage {
    String code;
    String name;
    String postalCode;

    DatumVillage({
        required this.code,
        required this.name,
        required this.postalCode,
    });

    factory DatumVillage.fromJson(Map<String, dynamic> json) => DatumVillage(
        code: json["code"],
        name: json["name"],
        postalCode: json["postal_code"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "postal_code": postalCode,
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
