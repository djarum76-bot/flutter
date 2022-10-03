import 'package:bloc_api_login/repositories/post_repository.dart';
import 'package:bloc_api_login/utils/validators/default_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class PostEditState extends Equatable{
  const PostEditState({
    this.title = const Default.pure(),
    this.body = const Default.pure(),
    this.status = FormzStatus.pure
  });

  final Default title;
  final Default body;
  final FormzStatus status;

  @override
  List<Object?> get props => [title, body, status];

  PostEditState copyWith({
    Default? title,
    Default? body,
    FormzStatus? status
  }) {
    return PostEditState(
      title: title ?? this.title,
      body: body ?? this.body,
      status: status ?? this.status,
    );
  }
}

class PostEditCubit extends Cubit<PostEditState>{
  PostEditCubit() : super(const PostEditState());

  final _postRepository = PostRepository();

  void titleChanged(String value){
    final title = Default.dirty(value);
    emit(state.copyWith(
      title: title,
      status: Formz.validate([
        title,
        state.body
      ])
    ));
  }

  void bodyChanged(String value){
    final body = Default.dirty(value);
    emit(state.copyWith(
      body: body,
      status: Formz.validate([
        state.title,
        body
      ])
    ));
  }

  Future<void> submit(String title, String body, int id)async{
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try{
      await _postRepository.updatePost(title, body, id);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }catch(e){
      emit(state.copyWith(status: FormzStatus.submissionFailure));
      throw Exception(e);
    }
  }
}