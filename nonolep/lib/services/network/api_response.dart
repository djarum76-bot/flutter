// To parse this JSON data, do
//
//     final apiResponse = apiResponseFromJson(jsonString);

import 'dart:convert';

class ApiResponse<T> {
  ApiResponse({this.data, required this.code, required this.message, required this.error});

  final T? data;
  final int code;
  final String message;
  final bool error;

  ApiResponse<T> copyWith({
    T? data,
    int? code,
    String? message,
    bool? error,
  }) {
    return ApiResponse<T>(
      data: data ?? data,
      code: code ?? this.code,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }

  factory ApiResponse.fromRawJson(String str) => ApiResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
    data: json["data"],
    code: json["code"],
    message: json["message"],
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "code": code,
    "message": message,
    "error": error,
  };
}