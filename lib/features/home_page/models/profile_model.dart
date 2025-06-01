// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  bool status;
  String message;
  User user;
  UserProfile? userProfile;

  ProfileModel({
    required this.status,
    required this.message,
    required this.user,
    this.userProfile,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        status: json["status"],
        message: json["message"],
        user: User.fromJson(json["user"]),
        userProfile:
            json.containsKey("user_profile") && json["user_profile"] != null
                ? UserProfile.fromJson(json["user_profile"])
                : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user.toJson(),
        if (userProfile != null) "user_profile": userProfile!.toJson(),
      };
}

class User {
  int id;
  String name;
  String email;
  String role;
  String createdAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "role": role,
        "created_at": createdAt,
      };
}

class UserProfile {
  int desaId;
  String? nomorIndukKependudukan;
  String? kartuKeluarga;
  String? phoneNumber;
  String? address;
  String? status;
  String? role;
  String profilePicture;
  String? provinsi;
  String? kabupaten;
  String? kecamatan;
  String? desa;

  UserProfile({
    this.desaId = 0,
    this.nomorIndukKependudukan,
    this.kartuKeluarga,
    this.phoneNumber,
    this.address,
    this.status,
    this.role,
    this.profilePicture = "",
    this.provinsi,
    this.kabupaten,
    this.kecamatan,
    this.desa,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        desaId: json["desa_id"] ?? 0,
        nomorIndukKependudukan: json["nomor_induk_kependudukan"],
        kartuKeluarga: json["kartu_keluarga"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        status: json["status"],
        role: json["role"],
        profilePicture: json["profile_picture"] ?? "",
        provinsi: json["provinsi"] ?? "",
        kabupaten: json["kabupaten"] ?? "",
        kecamatan: json["kecamatan"] ?? "",
        desa: json["desa"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "desa_id": desaId,
        "nomor_induk_kependudukan": nomorIndukKependudukan,
        "kartu_keluarga": kartuKeluarga,
        "phone_number": phoneNumber,
        "address": address,
        "status": status,
        "role": role,
        "profile_picture": profilePicture,
        "provinsi": provinsi,
        "kabupaten": kabupaten,
        "kecamatan": kecamatan,
        "desa": desa,
      };
}
