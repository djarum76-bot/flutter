import 'dart:convert';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:blocinfinitelist/posts/posts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

part 'post_event.dart';
part 'post_state.dart';

const _postLimit = 200;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration){
  return (events, mapper){
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState>{
  PostBloc({required this.httpClient}) : super(const PostState()){
    on<PostFetched>(
        _onPostFetched,
        transformer: throttleDroppable(throttleDuration)
    );
  }

  final http.Client httpClient;

  Future<void> _onPostFetched(PostFetched event, Emitter<PostState> emit)async{
    if(state.hasReachedMax) return;
    try{
      if(state.status == PostStatus.initial){
        final posts = await _fetchPost();
        return emit(state.copyWith(
          status: PostStatus.success,
          posts: posts,
          hasReachedMax: false
        ));
      }
      final posts = await _fetchPost(state.posts.length);
      emit(posts.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: PostStatus.success,
              posts: List.of(state.posts)..addAll(posts),
              hasReachedMax: false
            )
      );
    }catch (_){
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  Future<List<Post>> _fetchPost([int startIndex = 0])async{
    final response = await httpClient.get(
      Uri.https(
          'jsonplaceholder.typicode.com',
          '/posts',
          <String, String>{'_start' : '$startIndex', '_limit' : '$_postLimit'}
      )
    );

    if(response.statusCode == 200){
      final body = json.decode(response.body) as List;
      return body.map((json){
        final map = json as Map<String, dynamic>;
        return Post(
            id: map['id'] as int,
            title: map['title'] as String,
            body: map['body'] as String
        );
      }).toList();
    }
    throw Exception('error get posts');
  }
}