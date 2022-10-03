import 'package:bloc_ril_api_login/bloc/posts/posts_event.dart';
import 'package:bloc_ril_api_login/bloc/posts/posts_state.dart';
import 'package:bloc_ril_api_login/repositories/post_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState>{
  final PostRepository postRepository;

  PostsBloc({required this.postRepository}) : super(const PostsState()){
    on<PostsFetched>(
      _onPostsFetched
    );
  }

  Future<void> _onPostsFetched(PostsFetched event, Emitter<PostsState>emit)async{
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try{
      final postsModel = await postRepository.getAllPost();
      emit(state.copyWith(
        postsModel: postsModel,
        status: FormzStatus.submissionSuccess
      ));
    }catch(e){
      emit(state.copyWith(
        message: e.toString(),
        status: FormzStatus.submissionFailure
      ));
      throw Exception(e);
    }
  }
}