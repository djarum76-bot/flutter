import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:instagram_bloc/models/comment_model.dart';
import 'package:instagram_bloc/repositories/comment_repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState>{
  final CommentRepository commentRepository;
  CommentBloc({required this.commentRepository}) : super(const CommentState()) {
    on<CommentFetched>(
      _onCommentFetched
    );
    on<CreateComment>(
      _onCreateComment
    );
  }

  Future<void> _onCommentFetched(CommentFetched event, Emitter<CommentState> emit)async{
    try{
      final list = await commentRepository.getAllComment(event.postId);
      emit(state.copyWith(comments: list));
    }catch(e){
      emit(state.copyWith(
        message: e.toString(),
        status: FormzStatus.submissionFailure
      ));
      throw Exception(e);
    }
  }

  Future<void> _onCreateComment(CreateComment event, Emitter<CommentState> emit)async{
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try{
      await commentRepository.createComment(event.postId, event.comment);
      final list = await commentRepository.getAllComment(event.postId);
      emit(state.copyWith(
        comments: list,
        status: FormzStatus.submissionSuccess
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