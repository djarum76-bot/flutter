import 'package:bloc_ril_api_login/utils/any_service.dart';
import 'package:bloc_ril_api_login/utils/constants.dart';
import 'package:dio/dio.dart';

class AuthRepository{
  Future<void> register(String email, String password)async{
    try{
      FormData formData = FormData.fromMap({
        Constants.email : email,
        Constants.password : password
      });

      final response = await dio.post("/register",
        data: formData,
        options: Options(
          headers: {
            Constants.accept : Constants.appJson,
          }
        )
      );
      
      if(response.statusCode == 200){
        await box.write(Constants.token, response.data[Constants.token]);
      }else{
        throw Exception();
      }
    }catch(e){
      throw Exception(e);
    }
  }

  Future<void> logIn(String email, String password)async{
    try{
      FormData formData = FormData.fromMap({
        Constants.email : email,
        Constants.password : password
      });

      final response = await dio.post("/login",
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
        throw Exception();
      }
    }catch(e){
      throw Exception(e);
    }
  }

  Future<void> logOut()async{
    await box.remove(Constants.token);
    await box.erase();
  }
}