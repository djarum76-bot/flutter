import 'package:dio/dio.dart';

var options = BaseOptions(
  baseUrl: 'http://192.168.100.158:9000',
  connectTimeout: 5000,
  receiveTimeout: 3000,
);

Dio dio = Dio(options);