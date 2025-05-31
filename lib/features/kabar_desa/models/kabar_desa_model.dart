// To parse this JSON data, do
//
//     final kabarDesaModel = kabarDesaModelFromJson(jsonString);

import 'dart:convert';

KabarDesaModel kabarDesaModelFromJson(String str) => KabarDesaModel.fromJson(json.decode(str));

String kabarDesaModelToJson(KabarDesaModel data) => json.encode(data.toJson());

class KabarDesaModel {
    bool? status;
    String? message;
    List<KabarDesa>? kabarDesa;

    KabarDesaModel({
        this.status,
        this.message,
        this.kabarDesa,
    });

    factory KabarDesaModel.fromJson(Map<String, dynamic> json) => KabarDesaModel(
        status: json["status"],
        message: json["message"],
        kabarDesa: json["kabar_desa"] == null ? [] : List<KabarDesa>.from(json["kabar_desa"]!.map((x) => KabarDesa.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "kabar_desa": kabarDesa == null ? [] : List<dynamic>.from(kabarDesa!.map((x) => x.toJson())),
    };
}

class KabarDesa {
    int? id;
    int? userId;
    String? title;
    String? description;
    String? picturePath;
    DateTime? createdAt;
    DateTime? updatedAt;
    User? user;

    KabarDesa({
        this.id,
        this.userId,
        this.title,
        this.description,
        this.picturePath,
        this.createdAt,
        this.updatedAt,
        this.user,
    });

    factory KabarDesa.fromJson(Map<String, dynamic> json) => KabarDesa(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        description: json["description"],
        picturePath: json["picture_path"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "description": description,
        "picture_path": picturePath,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
    };
}

class User {
    int? id;
    String? name;
    String? email;
    String? role;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic otpCode;
    dynamic otpExpiresAt;
    DateTime? emailVerifiedAt;
    UserProfile? userProfile;

    User({
        this.id,
        this.name,
        this.email,
        this.role,
        this.createdAt,
        this.updatedAt,
        this.otpCode,
        this.otpExpiresAt,
        this.emailVerifiedAt,
        this.userProfile,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        otpCode: json["otp_code"],
        otpExpiresAt: json["otp_expires_at"],
        emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
        userProfile: json["user_profile"] == null ? null : UserProfile.fromJson(json["user_profile"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "role": role,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "otp_code": otpCode,
        "otp_expires_at": otpExpiresAt,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "user_profile": userProfile?.toJson(),
    };
}

class UserProfile {
    int? id;
    int? userId;
    String? nomorIndukKependudukan;
    String? kartuKeluarga;
    String? phoneNumber;
    String? address;
    String? status;
    String? profilePicture;
    int? desaId;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? provinsi;
    String? kabupaten;
    String? kecamatan;
    String? desa;

    UserProfile({
        this.id,
        this.userId,
        this.nomorIndukKependudukan,
        this.kartuKeluarga,
        this.phoneNumber,
        this.address,
        this.status,
        this.profilePicture,
        this.desaId,
        this.createdAt,
        this.updatedAt,
        this.provinsi,
        this.kabupaten,
        this.kecamatan,
        this.desa,
    });

    factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        userId: json["user_id"],
        nomorIndukKependudukan: json["nomor_induk_kependudukan"],
        kartuKeluarga: json["kartu_keluarga"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        status: json["status"],
        profilePicture: json["profile_picture"],
        desaId: json["desa_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        provinsi: json["provinsi"],
        kabupaten: json["kabupaten"],
        kecamatan: json["kecamatan"],
        desa: json["desa"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "nomor_induk_kependudukan": nomorIndukKependudukan,
        "kartu_keluarga": kartuKeluarga,
        "phone_number": phoneNumber,
        "address": address,
        "status": status,
        "profile_picture": profilePicture,
        "desa_id": desaId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "provinsi": provinsi,
        "kabupaten": kabupaten,
        "kecamatan": kecamatan,
        "desa": desa,
    };
}
