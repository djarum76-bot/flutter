part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class CommentFetched extends CommentEvent{
  final int postId;

  CommentFetched(this.postId);
}

class CreateComment extends CommentEvent{
  final int postId;
  final String comment;

  CreateComment(this.postId, this.comment);
}