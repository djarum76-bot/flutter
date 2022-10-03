import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_bloc/models/post_model.dart';
import 'package:instagram_bloc/repositories/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState>{
  final PostRepository postRepository;
  PostBloc({required this.postRepository}) : super(const PostState()) {
    on<AllPostFetched>(
      _onAllPostFetched
    );
    on<PostFetched>(
      _onPostFetched
    );
    on<CreatePost>(
      _onCreatePost
    );
    on<TakeImage>(
      _onTakeImage
    );
    on<PostDeleted>(
      _onPostDeleted
    );
    on<LikePost>(
      _onLikePost
    );
    on<UnlikePost>(
      _onUnlikePost
    );
  }

  Future<void> _onAllPostFetched(AllPostFetched event, Emitter<PostState> emit)async{
    try{
      final list = await postRepository.getAllPost();
      emit(state.copyWith(
        posts: list
      ));
    }catch(e){
      emit(state.copyWith(
        message: e.toString(),
        status: FormzStatus.submissionFailure
      ));
      throw Exception(e);
    }
  }

  Future<void> _onPostFetched(PostFetched event, Emitter<PostState> emit)async{
    try{
      final post = await postRepository.getPost(event.id);
      emit(state.copyWith(
        post: post
      ));
    }catch(e){
      emit(state.copyWith(
        message: e.toString(),
        status: FormzStatus.submissionFailure
      ));
      throw Exception(e);
    }
  }

  Future<void> _onCreatePost(CreatePost event, Emitter<PostState> emit)async{
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try{
      await postRepository.createPost(event.imagePath, event.caption);
      final newList = await postRepository.getAllPost();
      emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
        image: () => null,
        posts: newList
      ));
    }catch(e){
      emit(state.copyWith(
        message: e.toString(),
        status: FormzStatus.submissionFailure
      ));
      throw Exception(e);
    }
  }

  Future<void> _onTakeImage(TakeImage event, Emitter<PostState> emit)async{
    try{
      XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);

      if(image != null){
        emit(state.copyWith(image: () => image.path));
      }
    }catch(e){
      emit(state.copyWith(
          message: e.toString(),
          status: FormzStatus.submissionFailure
      ));
      throw Exception(e);
    }
  }

  Future<void> _onPostDeleted(PostDeleted event, Emitter<PostState> emit)async{
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try{
      await postRepository.deletePost(event.id);
      final newList = await postRepository.getAllPost();
      emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
        posts: newList
      ));
    }catch(e){
      emit(state.copyWith(
          message: e.toString(),
          status: FormzStatus.submissionFailure
      ));
      throw Exception(e);
    }
  }

  Future<void> _onLikePost(LikePost event, Emitter<PostState> emit)async{
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try{
      await postRepository.likePost(event.postId);
      final newList = await postRepository.getAllPost();
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          posts: newList
      ));
    }catch(e){
      emit(state.copyWith(
        message: e.toString(),
        status: FormzStatus.submissionFailure
      ));
      throw Exception(e);
    }
  }

  Future<void> _onUnlikePost(UnlikePost event, Emitter<PostState> emit)async{
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try{
      await postRepository.unlikePost(event.id);
      final newList = await postRepository.getAllPost();
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          posts: newList
      ));
    }catch(e){
      emit(state.copyWith(
          message: e.toString(),
          status: FormzStatus.submissionFailure
      ));
      throw Exception(e);
    }
  }
}