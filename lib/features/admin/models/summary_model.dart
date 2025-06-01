// To parse this JSON data, do
//
//     final summaryModel = summaryModelFromJson(jsonString);

import 'dart:convert';

SummaryModel summaryModelFromJson(String str) => SummaryModel.fromJson(json.decode(str));

String summaryModelToJson(SummaryModel data) => json.encode(data.toJson());

class SummaryModel {
    bool status;
    String message;
    Data data;

    SummaryModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory SummaryModel.fromJson(Map<String, dynamic> json) => SummaryModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    int totalWarga;
    String retribusiLabel;
    int permohonanSurat;
    String danaDesaLabel;
    int aspirasi;
    int musyawarah;
    int agendaDesa;

    Data({
        required this.totalWarga,
        required this.retribusiLabel,
        required this.permohonanSurat,
        required this.danaDesaLabel,
        required this.aspirasi,
        required this.musyawarah,
        required this.agendaDesa,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalWarga: json["total_warga"],
        retribusiLabel: json["retribusi_label"],
        permohonanSurat: json["permohonan_surat"],
        danaDesaLabel: json["dana_desa_label"],
        aspirasi: json["aspirasi"],
        musyawarah: json["musyawarah"],
        agendaDesa: json["agenda_desa"],
    );

    Map<String, dynamic> toJson() => {
        "total_warga": totalWarga,
        "retribusi_label": retribusiLabel,
        "permohonan_surat": permohonanSurat,
        "dana_desa_label": danaDesaLabel,
        "aspirasi": aspirasi,
        "musyawarah": musyawarah,
        "agenda_desa": agendaDesa,
    };
}
