// To parse this JSON data, do
//
//     final historyTransaksiModel = historyTransaksiModelFromJson(jsonString);

import 'dart:convert';

List<HistoryTransaksiModel> historyTransaksiModelFromJson(String str) => List<HistoryTransaksiModel>.from(json.decode(str).map((x) => HistoryTransaksiModel.fromJson(x)));

String historyTransaksiModelToJson(List<HistoryTransaksiModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryTransaksiModel {
    int id;
    int userId;
    int desaId;
    int sampahFeeId;
    String paymentMethod;
    String transactionStatus;
    String midtransOrderId;
    String amount;
    DateTime createdAt;
    DateTime updatedAt;
    User user;

    HistoryTransaksiModel({
        required this.id,
        required this.userId,
        required this.desaId,
        required this.sampahFeeId,
        required this.paymentMethod,
        required this.transactionStatus,
        required this.midtransOrderId,
        required this.amount,
        required this.createdAt,
        required this.updatedAt,
        required this.user,
    });

    factory HistoryTransaksiModel.fromJson(Map<String, dynamic> json) => HistoryTransaksiModel(
        id: json["id"],
        userId: json["user_id"],
        desaId: json["desa_id"],
        sampahFeeId: json["sampah_fee_id"],
        paymentMethod: json["payment_method"],
        transactionStatus: json["transaction_status"],
        midtransOrderId: json["midtrans_order_id"],
        amount: json["amount"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "desa_id": desaId,
        "sampah_fee_id": sampahFeeId,
        "payment_method": paymentMethod,
        "transaction_status": transactionStatus,
        "midtrans_order_id": midtransOrderId,
        "amount": amount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
    };
}

class User {
    int id;
    String name;
    String email;
    String role;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic otpCode;
    dynamic otpExpiresAt;
    DateTime emailVerifiedAt;

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
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
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
        "email_verified_at": emailVerifiedAt.toIso8601String(),
    };
}
