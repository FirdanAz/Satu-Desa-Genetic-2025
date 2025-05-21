// To parse this JSON data, do
//
//     final aspirasiModel = aspirasiModelFromJson(jsonString);

import 'dart:convert';

List<AspirasiModel> aspirasiModelFromJson(String str) =>
    List<AspirasiModel>.from(
        json.decode(str).map((x) => AspirasiModel.fromJson(x)));

String aspirasiModelToJson(List<AspirasiModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AspirasiModel {
  int id;
  int userId;
  String judul;
  String deskripsi;
  String lokasi;
  int anonim;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  User user;
  List<Image> images;

  AspirasiModel({
    required this.id,
    required this.userId,
    required this.judul,
    required this.deskripsi,
    required this.lokasi,
    required this.anonim,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.images,
  });

  factory AspirasiModel.fromJson(Map<String, dynamic> json) => AspirasiModel(
        id: json["id"],
        userId: json["user_id"],
        judul: json["judul"],
        deskripsi: json["deskripsi"],
        lokasi: json["lokasi"],
        anonim: json["anonim"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "judul": judul,
        "deskripsi": deskripsi,
        "lokasi": lokasi,
        "anonim": anonim,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class Image {
  int id;
  int aspirasiId;
  String path;
  DateTime createdAt;
  DateTime updatedAt;

  Image({
    required this.id,
    required this.aspirasiId,
    required this.path,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        aspirasiId: json["aspirasi_id"],
        path: json["path"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "aspirasi_id": aspirasiId,
        "path": path,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class User {
  int id;
  String name;
  String email;
  String role;
  DateTime createdAt;
  DateTime updatedAt;
  String? otpCode;
  String? otpExpiresAt;
  DateTime? emailVerifiedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.otpCode,
    required this.otpExpiresAt,
    required this.emailVerifiedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        otpCode: json["otp_code"],
        otpExpiresAt: json["otp_expires_at"],
        emailVerifiedAt: json["email_verified_at"] != null
            ? DateTime.parse(json["email_verified_at"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "role": role,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "otp_code": otpCode,
        "otp_expires_at": otpExpiresAt,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
      };
}
