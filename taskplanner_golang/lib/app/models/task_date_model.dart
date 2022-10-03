// To parse this JSON data, do
//
//     final taskDateModel = taskDateModelFromJson(jsonString);

import 'dart:convert';

TaskDateModel taskDateModelFromJson(String str) => TaskDateModel.fromJson(json.decode(str));

String taskDateModelToJson(TaskDateModel data) => json.encode(data.toJson());

class TaskDateModel {
  TaskDateModel({
    this.status,
    this.pesan,
    this.data,
  });

  int? status;
  String? pesan;
  List<Datum>? data;

  factory TaskDateModel.fromJson(Map<String, dynamic> json) => TaskDateModel(
    status: json["status"],
    pesan: json["pesan"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "pesan": pesan,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.tanggal,
    this.task,
  });

  DateTime? tanggal;
  List<Task>? task;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    tanggal: DateTime.parse(json["tanggal"]),
    task: List<Task>.from(json["task"].map((x) => Task.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tanggal": "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
    "task": List<dynamic>.from(task!.map((x) => x.toJson())),
  };
}

class Task {
  Task({
    this.id,
    this.userId,
    this.title,
    this.tanggal,
    this.waktu,
    this.date,
    this.deskripsi,
  });

  int? id;
  int? userId;
  String? title;
  DateTime? tanggal;
  String? waktu;
  DateTime? date;
  String? deskripsi;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json["id"],
    userId: json["user_id"],
    title: json["title"],
    tanggal: DateTime.parse(json["tanggal"]),
    waktu: json["waktu"],
    date: DateTime.parse(json["date"]),
    deskripsi: json["deskripsi"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "tanggal": "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
    "waktu": waktu,
    "date": date!.toIso8601String(),
    "deskripsi": deskripsi,
  };
}
