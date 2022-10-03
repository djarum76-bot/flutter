import 'package:bloc_ril_api_login/models/posts_model.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class PostsState extends Equatable{
  const PostsState({
    this.postsModel,
    this.status = FormzStatus.pure,
    this.message
  });

  final PostsModel? postsModel;
  final FormzStatus status;
  final String? message;

  PostsState copyWith({
    PostsModel? postsModel,
    FormzStatus? status,
    String? message
  }) {
    return PostsState(
      postsModel: postsModel ?? this.postsModel,
      status: status ?? this.status,
      message: message ?? this.message
    );
  }

  @override
  String toString(){
    return '''PostsState { status : $status }''';
  }

  @override
  List<Object?> get props => [postsModel, status];
}