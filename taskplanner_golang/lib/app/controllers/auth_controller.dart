import 'package:dio/dio.dart' as Dio;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

var options = Dio.BaseOptions(
  // baseUrl: 'http://192.168.1.211:8080',
  baseUrl: 'https://tranquil-bastion-82068.herokuapp.com',
  connectTimeout: 5000,
  receiveTimeout: 3000,
);

Dio.Dio dio = Dio.Dio(options);

class AuthController extends GetxController {
  final box = GetStorage();

  getNewToken(Future<void> Function() fungsi)async{
    Dio.FormData formData = Dio.FormData.fromMap({
      'username':box.read('username'),
      'password':box.read('password'),
    });

    final response = await dio.post('/login',
        data: formData,
        options: Dio.Options(
            headers: {
              "Accept": "application/json"
            }
        )
    );

    final data = response.data;

    if(response.statusCode == 200){
      box.write('token', data["token"]);
    }else{
      fungsi();
    }
  }
}
