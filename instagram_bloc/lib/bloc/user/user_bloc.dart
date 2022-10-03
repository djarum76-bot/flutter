import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_bloc/models/user_model.dart';
import 'package:instagram_bloc/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(const UserState()){
    on<UserFetched>(
      _onUserFetched
    );
    on<CompleteProfile>(
      _onCompleteProfile
    );
    on<TakePicture>(
      _onTakePicture
    );
  }

  Future<void> _onUserFetched(UserFetched event, Emitter<UserState> emit)async{
    try{
      final userModel = await userRepository.getUser();
      emit(state.copyWith(
        userModel: userModel,
      ));
    }catch(e){
      emit(state.copyWith(
        message: e.toString(),
        status: FormzStatus.submissionFailure
      ));
      throw Exception(e);
    }
  }

  Future<void> _onCompleteProfile(CompleteProfile event, Emitter<UserState> emit)async{
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try{
      await userRepository.completeProfile(event.phone, event.imagePath);
      emit(state.copyWith(
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

  Future<void> _onTakePicture(TakePicture event, Emitter<UserState> emit)async{
    try{
      XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);

      if(image != null){
        emit(state.copyWith(image: image.path));
      }
    }catch(e){
      emit(state.copyWith(
        image: null
      ));
      throw Exception(e);
    }
  }
}