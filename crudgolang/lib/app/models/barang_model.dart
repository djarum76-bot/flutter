// To parse this JSON data, do
//
//     final barangModel = barangModelFromJson(jsonString);

import 'dart:convert';

BarangModel barangModelFromJson(String str) => BarangModel.fromJson(json.decode(str));

String barangModelToJson(BarangModel data) => json.encode(data.toJson());

class BarangModel {
  BarangModel({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  Data? data;

  factory BarangModel.fromJson(Map<String, dynamic> json) => BarangModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.kodebarang,
    this.namabarang,
  });

  int? id;
  String? kodebarang;
  String? namabarang;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
