import 'package:dio/dio.dart';
import 'package:instagram_bloc/models/comment_model.dart';
import 'package:instagram_bloc/utils/any_service.dart';
import 'package:instagram_bloc/utils/constants.dart';

class CommentRepository{
  Future<List<CommentModel>> getAllComment(int postId)async{
    try{
      final response = await dio.get("/auth/comment/$postId",
        options: Options(
          headers: {
            Constants.accept : Constants.appJson,
            Constants.authorization : "${Constants.bearer} ${box.read(Constants.token)}"
          }
        )
      );

      if(response.statusCode == 200){
        final datas = response.data as List;
        final list = datas.map((data) => CommentModel.fromJson(data)).toList();
        return list;
      }else{
        throw Exception();
      }
    }catch(e){
      throw Exception(e);
    }
  }

  Future<void> createComment(int postId, String comment)async{
    try{
      FormData formData = FormData.fromMap({
        Constants.comment : comment,
        Constants.createdAt : DateTime.now().toIso8601String()
      });


      await dio.post("/auth/comment/$postId",
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