import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instagram_bloc/utils/constants.dart';

final box = GetStorage();

var options = BaseOptions(
  baseUrl: Constants.baseURL,
  connectTimeout: 5000,
  receiveTimeout: 3000
);

Dio dio = Dio(options);