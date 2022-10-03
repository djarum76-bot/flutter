import 'package:bloc_api_login/models/posts_model.dart';
import 'package:bloc_api_login/repositories/post_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsState extends Equatable{
  const PostsState({
    this.postsModel
  });

  final PostsModel? postsModel;

  @override
  List<Object?> get props => [postsModel];

  PostsState copyWith({
    PostsModel? postsModel
  }) {
    return PostsState(
      postsModel: postsModel ?? this.postsModel
    );
  }
}

class PostsCubit extends Cubit<PostsState>{
  PostsCubit() : super(const PostsState());

  final _postRepository = PostRepository();

  Future<void> getAllPost()async{
    try{
      final postsModel = await _postRepository.getAllPost();
      emit(state.copyWith(
        postsModel: postsModel
      ));
    }catch(e){
      throw Exception();
    }
  }
}