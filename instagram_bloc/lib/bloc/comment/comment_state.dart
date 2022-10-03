part of 'comment_bloc.dart';

class CommentState extends Equatable{
  const CommentState({
    this.comments = const <CommentModel>[],
    this.status = FormzStatus.pure,
    this.message
  });

  final List<CommentModel> comments;
  final FormzStatus status;
  final String? message;

  @override
  List<Object?> get props => [comments, status];

  @override
  String toString(){
    return '''CommentState { status : $status }''';
  }

  CommentState copyWith({
    List<CommentModel>? comments,
    FormzStatus? status,
    String? message
  }) {
    return CommentState(
      comments: comments ?? this.comments,
      status: status ?? this.status,
      message: message ?? this.message
    );
  }
}