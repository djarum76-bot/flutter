import 'package:bloc_api_login/models/post_model.dart';
import 'package:bloc_api_login/repositories/post_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class PostState extends Equatable{
  const PostState({
    this.postModel,
    this.status = FormzStatus.pure
  });

  final PostModel? postModel;
  final FormzStatus status;

  @override
  List<Object?> get props => [postModel, status];

  PostState copyWith({
    PostModel? postModel,
    FormzStatus? status
  }) {
    return PostState(
      postModel: postModel ?? this.postModel,
      status: status ?? this.status
    );
  }
}

class PostCubit extends Cubit<PostState>{
  PostCubit() : super(const PostState());

  final _postRepository = PostRepository();

  Future<void> getPost(int id)async{
    try{
      final postModel = await _postRepository.getPost(id);
      emit(state.copyWith(
          postModel: postModel
      ));
    }catch(e){
      emit(state.copyWith(status: FormzStatus.submissionFailure));
      throw Exception(e);
    }
  }

  Future<void> deletePost(int id)async{
    try{
      await _postRepository.deletePost(id);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }catch(e){
      emit(state.copyWith(status: FormzStatus.submissionFailure));
      throw Exception(e);
    }
  }
}