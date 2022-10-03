part of 'post_bloc.dart';

class PostState extends Equatable{
  const PostState({
    this.postModel,
    this.status = FormzStatus.pure,
    this.message
  });

  final PostModel? postModel;
  final FormzStatus status;
  final String? message;

  PostState copyWith({
    PostModel? postModel,
    FormzStatus? status,
    String? message
  }) {
    return PostState(
      postModel: postModel ?? this.postModel,
      status: status ?? this.status,
      message: message ?? this.message
    );
  }

  @override
  String toString(){
    return '''PostState { status : $status }''';
  }

  @override
  List<Object?> get props => [postModel, status];
}