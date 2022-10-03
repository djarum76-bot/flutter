import 'package:bloc_api_login/models/user_model.dart';
import 'package:bloc_api_login/utils/constants.dart';
import 'package:dio/dio.dart';

class UserRepository{
  Future<UserModel> getUser()async{
    try{
      final response = await dio.get("/auth/user",
        options: Options(
          headers: {
            Constants.accept : Constants.appJson,
            Constants.authorization : "bearer ${box.read(Constants.token)}"
          }
        )
      );

      if(response.statusCode == 200){
        return UserModel.fromJson(response.data);
      }else{
        throw Exception();
      }
    }catch(e){
      throw Exception(e);
    }
  }
}