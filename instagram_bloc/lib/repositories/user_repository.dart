import 'package:dio/dio.dart';
import 'package:instagram_bloc/models/user_model.dart';
import 'package:instagram_bloc/utils/any_service.dart';
import 'package:instagram_bloc/utils/constants.dart';

class UserRepository{
  Future<UserModel> getUser()async{
    try{
      final response = await dio.get("/auth/user",
        options: Options(
          headers: {
            Constants.accept : Constants.appJson,
            Constants.authorization : "${Constants.bearer} ${box.read(Constants.token)}"
          }
        ),
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

  Future<void> completeProfile(String phone, String imagePath)async{
    try{
      FormData formData = FormData.fromMap({
        Constants.phone : phone,
        Constants.picture : await MultipartFile.fromFile(imagePath, filename: imagePath.split('/').last)
      });

      await dio.put("/auth/complete-profile",
          data: formData,
          options: Options(
              headers: {
                Constants.accept : Constants.appJson,
                Constants.authorization : "${Constants.bearer} ${box.read(Constants.token)}"
              }
          )
      );
    }catch(e){
      throw Exception(e);
    }
  }
}