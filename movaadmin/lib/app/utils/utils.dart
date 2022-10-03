import 'package:dio/dio.dart';

var options = BaseOptions(
    baseUrl: "http://192.168.100.51:8080",
    connectTimeout: 5000,
    receiveTimeout: 3000
);

Dio dio = Dio(options);