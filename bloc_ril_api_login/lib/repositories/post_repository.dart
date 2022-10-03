import 'package:bloc_ril_api_login/models/post_model.dart';
import 'package:bloc_ril_api_login/models/posts_model.dart';
import 'package:bloc_ril_api_login/utils/any_service.dart';
import 'package:bloc_ril_api_login/utils/constants.dart';
import 'package:dio/dio.dart';

class PostRepository{
  Future<PostsModel> getAllPost()async{
    try{
      final response = await dio.get("/auth/posts",
        options: Options(
          headers: {
            Constants.accept : Constants.appJson,
            Constants.authorization : "${Constants.bearer} ${box.read(Constants.token)}"
          }
        )
      );

      if(response.statusCode == 200){
        return PostsModel.fromJson(response.data);
      }else{
        throw Exception();
      }
    }catch(e){
      throw Exception(e);
    }
  }

  Future<PostModel> getPost(int id)async{
    try{
      final response = await dio.get("/auth/post/$id",
        options: Options(
          headers: {
            Constants.accept : Constants.appJson,
            Constants.authorization : "${Constants.bearer} ${box.read(Constants.token)}"
          }
        )
      );

      if(response.statusCode == 200){
        return PostModel.fromJson(response.data);
      }else{
        throw Exception();
      }
    }catch(e){
      throw Exception(e);
    }
  }

  Future<void> deletePost(int id)async{
    try{
      await dio.delete("/auth/post/$id",
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

  Future<void> createPost(String title, String body)async{
    try{
      FormData formData = FormData.fromMap({
        Constants.title : title,
        Constants.body : body,
      });

      await dio.post("/auth/post",
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

  Future<void> updatePost(int id, String title, String body)async{
    try{
      FormData formData = FormData.fromMap({
        Constants.title : title,
        Constants.body : body
      });

      await dio.put("/auth/post/$id",
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