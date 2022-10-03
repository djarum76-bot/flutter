import 'package:bloc_ril_api_login/models/post_model.dart';
import 'package:bloc_ril_api_login/repositories/post_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'post_state.dart';
part 'post_event.dart';

class PostBloc extends Bloc<PostEvent, PostState>{
  final PostRepository postRepository;

  PostBloc({required this.postRepository}) : super(const PostState()){
    on<PostFetched>(
      _onPostFetched
    );
    on<PostDeleted>(
      _onPostDeleted
    );
    on<PostInserted>(
      _onPostInserted
    );
    on<PostUpdated>(
      _onPostUpdated
    );
  }

  Future<void> _onPostFetched(PostFetched event, Emitter<PostState> emit)async{
    try{
      final postModel = await postRepository.getPost(event.id);
      emit(state.copyWith(postModel: postModel));
    }catch(e){
      emit(state.copyWith(
        message: e.toString(),
        status: FormzStatus.submissionFailure
      ));
      throw Exception(e);
    }
  }

  Future<void> _onPostDeleted(PostDeleted event, Emitter<PostState> emit)async{
    try{
      await postRepository.deletePost(event.id);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }catch(e){
      emit(state.copyWith(
        message: e.toString(),
        status: FormzStatus.submissionFailure
      ));
      throw Exception(e);
    }
  }

  Future<void> _onPostInserted(PostInserted event, Emitter<PostState> emit)async{
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try{
      await postRepository.createPost(event.title, event.body);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }catch(e){
      emit(state.copyWith(
        message: e.toString(),
        status: FormzStatus.submissionFailure
      ));
      throw Exception(e);
    }
  }

  Future<void> _onPostUpdated(PostUpdated event, Emitter<PostState> emit)async{
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try{
      await postRepository.updatePost(event.id, event.title, event.body);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }catch(e){
      emit(state.copyWith(
        message: e.toString(),
        status: FormzStatus.submissionFailure
      ));
      throw Exception(e);
    }
  }
}