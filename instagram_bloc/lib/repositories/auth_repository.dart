import 'package:dio/dio.dart';
import 'package:instagram_bloc/utils/any_service.dart';
import 'package:instagram_bloc/utils/constants.dart';

class AuthRepository{
  Future<void> register(String username, String email, String password)async{
    try{
      FormData formData = FormData.fromMap({
        Constants.username : username,
        Constants.email : email,
        Constants.password : password,
        Constants.createdAt : DateTime.now().toIso8601String()
      });

      final response = await dio.post("/register",
        data: formData,
        options: Options(
          headers: {
            Constants.accept : Constants.appJson
          }
        )
      );

      if(response.statusCode == 200){
        await box.write(Constants.id, response.data[Constants.id]);
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
        await box.write(Constants.id, response.data[Constants.id]);
        await box.write(Constants.token, response.data[Constants.token]);
      }else{
        throw Exception();
      }
    }catch(e){
      throw Exception(e);
    }
  }

  Future<void> logOut()async{
    await box.remove(Constants.id);
    await box.remove(Constants.token);
    await box.erase();
  }
}