part of 'post_bloc.dart';

abstract class PostEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class AllPostFetched extends PostEvent{}

class PostFetched extends PostEvent{
  final int id;

  PostFetched(this.id);
}

class CreatePost extends PostEvent{
  final String imagePath;
  final String caption;

  CreatePost(this.imagePath, this.caption);
}

class TakeImage extends PostEvent{}

class PostDeleted extends PostEvent{
  final int id;

  PostDeleted(this.id);
}

class LikePost extends PostEvent{
  final int postId;

  LikePost(this.postId);
}

class UnlikePost extends PostEvent{
  final int id;

  UnlikePost(this.id);
}