// To parse this JSON data, do
//
//     final tasksModel = tasksModelFromJson(jsonString);

import 'dart:convert';

TasksModel tasksModelFromJson(String str) => TasksModel.fromJson(json.decode(str));

String tasksModelToJson(TasksModel data) => json.encode(data.toJson());

class TasksModel {
  TasksModel({
    this.status,
    this.pesan,
    this.data,
  });

  int? status;
  String? pesan;
  List<Datum>? data;

  factory TasksModel.fromJson(Map<String, dynamic> json) => TasksModel(
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
  String? tanggal;
  String? waktu;
  String? date;
  String? deskripsi;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    title: json["title"],
    tanggal: json["tanggal"],
    waktu: json["waktu"],
    date: json["date"],
    deskripsi: json["deskripsi"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "tanggal": tanggal,
    "waktu": waktu,
    "date": date,
    "deskripsi": deskripsi,
  };
}
