import 'package:bloc_api_login/repositories/post_repository.dart';
import 'package:bloc_api_login/utils/validators/default_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class PostAddState extends Equatable{
  const PostAddState({
    this.title = const Default.pure(),
    this.body = const Default.pure(),
    this.status = FormzStatus.pure
  });

  final Default title;
  final Default body;
  final FormzStatus status;

  @override
  List<Object?> get props => [title, body, status];

  PostAddState copyWith({
    Default? title,
    Default? body,
    FormzStatus? status
  }) {
    return PostAddState(
      title: title ?? this.title,
      body: body ?? this.body,
      status: status ?? this.status
    );
  }
}

class PostAddCubit extends Cubit<PostAddState>{
  PostAddCubit() : super(const PostAddState());

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

  Future<void> submit()async{
    if(!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try{
      await _postRepository.addPost(state.title.value!, state.body.value!);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }catch(_){
      emit(state.copyWith(status: FormzStatus.submissionFailure));
      throw Exception();
    }
  }
}