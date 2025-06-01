// To parse this JSON data, do
//
//     final meetingModel = meetingModelFromJson(jsonString);

import 'dart:convert';

List<MeetingModel> meetingModelFromJson(String str) => List<MeetingModel>.from(json.decode(str).map((x) => MeetingModel.fromJson(x)));

String meetingModelToJson(List<MeetingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MeetingModel {
    int id;
    int desaId;
    String title;
    String description;
    DateTime date;
    String startTime;
    String endTime;
    String status;
    DateTime createdAt;
    DateTime updatedAt;
    List<Option> options;

    MeetingModel({
        required this.id,
        required this.desaId,
        required this.title,
        required this.description,
        required this.date,
        required this.startTime,
        required this.endTime,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.options,
    });

    factory MeetingModel.fromJson(Map<String, dynamic> json) => MeetingModel(
        id: json["id"],
        desaId: json["desa_id"],
        title: json["title"],
        description: json["description"],
        date: DateTime.parse(json["date"]),
        startTime: json["start_time"],
        endTime: json["end_time"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "desa_id": desaId,
        "title": title,
        "description": description,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "end_time": endTime,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
    };
}

class Option {
    int id;
    int meetingId;
    String text;
    int voteCount;
    DateTime createdAt;
    DateTime updatedAt;

    Option({
        required this.id,
        required this.meetingId,
        required this.text,
        required this.voteCount,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        meetingId: json["meeting_id"],
        text: json["text"],
        voteCount: json["vote_count"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "meeting_id": meetingId,
        "text": text,
        "vote_count": voteCount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
