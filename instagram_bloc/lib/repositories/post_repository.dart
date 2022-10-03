import 'package:dio/dio.dart';
import 'package:instagram_bloc/models/post_model.dart';
import 'package:instagram_bloc/utils/any_service.dart';
import 'package:instagram_bloc/utils/constants.dart';

class PostRepository{
  Future<List<PostModel>> getAllPost()async{
    try{
      final response = await dio.get("/auth/post",
        options: Options(
          headers: {
            Constants.accept : Constants.appJson,
            Constants.authorization : "${Constants.bearer} ${box.read(Constants.token)}"
          }
        )
      );

      if(response.statusCode == 200){
        final datas = response.data as List;
        final list = datas.map((data) => PostModel.fromJson(data)).toList();
        return list;
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

  Future<void> createPost(String imagePath, String caption)async{
    try{
      FormData formData = FormData.fromMap({
        Constants.image : await MultipartFile.fromFile(imagePath, filename: imagePath.split('/').last),
        Constants.caption : caption,
        Constants.createdAt : DateTime.now().toIso8601String()
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

  Future<void> likePost(int postId)async{
    try{
      await dio.post("/auth/like/$postId",
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

  Future<void> unlikePost(int id)async{
    try{
      await dio.delete("/auth/like/$id",
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