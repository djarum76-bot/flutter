part of 'post_bloc.dart';

abstract class PostEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class PostFetched extends PostEvent{
  final int id;

  PostFetched(this.id);
}

class PostDeleted extends PostEvent{
  final int id;

  PostDeleted(this.id);
}

class PostInserted extends PostEvent{
  final String title;
  final String body;

  PostInserted(this.title, this.body);
}

class PostUpdated extends PostEvent{
  final int id;
  final String title;
  final String body;

  PostUpdated(this.id, this.title, this.body);
}