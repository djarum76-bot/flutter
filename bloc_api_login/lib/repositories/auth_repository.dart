import 'package:bloc_api_login/utils/constants.dart';
import 'package:dio/dio.dart';

class RegisterFailure implements Exception{
  const RegisterFailure([
    this.message = "Error Cok"
  ]);

  final String message;
}

class LogInFailure implements Exception{
  const LogInFailure([
    this.message = "Error Cok"
  ]);

  final String message;
}

class LogOutFailure implements Exception{}

class AuthRepository{

  Future<void> register(String email, String password)async{
    try{
      FormData formData = FormData.fromMap({
        Constants.email : email,
        Constants.password : password
      });

      final response = await dio.post('/register',
          data: formData,
          options: Options(
              headers: {
                Constants.accept : Constants.appJson
              }
          )
      );

      if(response.statusCode == 200){
        await box.write(Constants.token, response.data[Constants.token]);
      }else{
        throw const RegisterFailure();
      }
    }catch(_){
      throw const RegisterFailure();
    }
  }

  Future<void> logIn(String email, String password)async{
    try{
      FormData formData = FormData.fromMap({
        Constants.email : email,
        Constants.password : password
      });

      final response = await dio.post('/login',
        data: formData,
        options: Options(
          headers: {
            Constants.accept : Constants.appJson
          }
        )
      );

      if(response.statusCode == 200){
        await box.write(Constants.token, response.data[Constants.token]);
      }else{
        throw const LogInFailure();
      }
    }catch(_){
      throw const LogInFailure();
    }
  }

  Future<void> logOut()async{
    try{
      await box.remove(Constants.token);
      await box.erase();
    }catch(_){
      throw LogOutFailure();
    }
  }
}