import 'package:bloc_ril_api_login/models/user_model.dart';
import 'package:bloc_ril_api_login/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'user_state.dart';
part 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(const UserState()){
    on<UserFetched>(
      _onUserFetched
    );
  }

  Future<void> _onUserFetched(UserFetched event, Emitter<UserState> emit)async{
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try{
      final user = await userRepository.getUser();
      emit(state.copyWith(
        user: user,
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