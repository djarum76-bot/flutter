import 'package:dio/dio.dart';
import 'package:get/get.dart';

var options = BaseOptions(
  baseUrl: 'http://192.168.100.158:3000',
  connectTimeout: 5000,
  receiveTimeout: 3000,
);

Dio dio = Dio(options);

class ServiceController extends GetxController {

}
