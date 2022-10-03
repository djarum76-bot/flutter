part of 'post_bloc.dart';

class PostState extends Equatable{
  const PostState({
    this.posts = const <PostModel>[],
    this.post,
    this.status = FormzStatus.pure,
    this.image,
    this.message
  });

  final List<PostModel> posts;
  final PostModel? post;
  final FormzStatus status;
  final String? image;
  final String? message;

  @override
  List<Object?> get props => [posts, post, status, image];

  PostState copyWith({
    List<PostModel>? posts,
    PostModel? post,
    FormzStatus? status,
    ValueGetter<String?>? image,
    String? message
  }) {
    return PostState(
      posts: posts ?? this.posts,
      post: post ?? this.post,
      status: status ?? this.status,
      image: image != null ? image() : this.image,
      message: message ?? this.message
    );
  }

  @override
  String toString(){
    return '''PostState { status : $status }''';
  }
}