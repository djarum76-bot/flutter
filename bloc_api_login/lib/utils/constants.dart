import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

final box = GetStorage();

var options = BaseOptions(
    baseUrl: Constants.baseUrl,
    connectTimeout: 5000,
    receiveTimeout: 3000
);

Dio dio = Dio(options);

class Constants{
  Constants._();

  static const baseUrl = "http://192.168.100.51:8080";

  static const email = "email";
  static const password = "password";
  static const token = "token";

  static const accept = "Accept";
  static const appJson = "application/json";
  static const authorization = "Authorization";

  static const title = "title";
  static const body = "body";
}