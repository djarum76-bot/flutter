// To parse this JSON data, do
//
//     final barangsModel = barangsModelFromJson(jsonString);

import 'dart:convert';

BarangsModel barangsModelFromJson(String str) => BarangsModel.fromJson(json.decode(str));

String barangsModelToJson(BarangsModel data) => json.encode(data.toJson());

class BarangsModel {
  BarangsModel({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  List<Datum>? data;

  factory BarangsModel.fromJson(Map<String, dynamic> json) => BarangsModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.kodebarang,
    this.namabarang,
  });

  int? id;
  String? kodebarang;
  String? namabarang;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    kodebarang: json["kodebarang"],
    namabarang: json["namabarang"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "kodebarang": kodebarang,
    "namabarang": namabarang,
  };
}
