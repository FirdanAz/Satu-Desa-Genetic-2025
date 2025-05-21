// To parse this JSON data, do
//
//     final danaDesaModel = danaDesaModelFromJson(jsonString);

import 'dart:convert';

DanaDesaModel danaDesaModelFromJson(String str) =>
    DanaDesaModel.fromJson(json.decode(str));

String danaDesaModelToJson(DanaDesaModel data) => json.encode(data.toJson());

class DanaDesaModel {
  bool status;
  String message;
  List<Datum> data;

  DanaDesaModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DanaDesaModel.fromJson(Map<String, dynamic> json) => DanaDesaModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  int desaId;
  String year;
  String totalAmount;
  DateTime createdAt;
  DateTime updatedAt;
  List<Usage> usages;

  Datum({
    required this.id,
    required this.desaId,
    required this.year,
    required this.totalAmount,
    required this.createdAt,
    required this.updatedAt,
    required this.usages,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        desaId: json["desa_id"],
        year: json["year"],
        totalAmount: json["total_amount"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        usages: List<Usage>.from(json["usages"].map((x) => Usage.fromJson(x))),
      );

  double get totalAmountValue => double.tryParse(totalAmount) ?? 0.0;

  double get usedAmount => usages.fold(0.0, (sum, usage) {
        return sum + (double.tryParse(usage.cost) ?? 0.0);
      });

  double get remainingAmount => totalAmountValue - usedAmount;

  Map<String, dynamic> toJson() => {
        "id": id,
        "desa_id": desaId,
        "year": year,
        "total_amount": totalAmount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "usages": List<dynamic>.from(usages.map((x) => x.toJson())),
      };
}

class Usage {
  int id;
  int villageFundId;
  String categoryType;
  String title;
  String description;
  String location;
  DateTime startDate;
  DateTime endDate;
  String cost;
  String? reportFile;
  DateTime createdAt;
  DateTime updatedAt;
  String? fundCode;
  List<Image> images;

  Usage({
    required this.id,
    required this.villageFundId,
    required this.categoryType,
    required this.title,
    required this.description,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.cost,
    required this.reportFile,
    required this.createdAt,
    required this.updatedAt,
    required this.fundCode,
    required this.images,
  });

  factory Usage.fromJson(Map<String, dynamic> json) => Usage(
        id: json["id"],
        villageFundId: json["village_fund_id"],
        categoryType: json["category_type"],
        title: json["title"],
        description: json["description"],
        location: json["location"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        cost: json["cost"],
        reportFile: json["report_file"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        fundCode: json["fund_code"] ?? "",
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "village_fund_id": villageFundId,
        "category_type": categoryType,
        "title": title,
        "description": description,
        "location": location,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "cost": cost,
        "report_file": reportFile,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "fund_code": fundCode,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class Image {
  int id;
  int villageFundUsageId;
  String imagePath;
  DateTime createdAt;
  DateTime updatedAt;

  Image({
    required this.id,
    required this.villageFundUsageId,
    required this.imagePath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        villageFundUsageId: json["village_fund_usage_id"],
        imagePath: json["image_path"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "village_fund_usage_id": villageFundUsageId,
        "image_path": imagePath,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
