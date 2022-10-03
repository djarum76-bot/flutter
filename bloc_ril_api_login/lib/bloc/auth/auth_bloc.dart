import 'package:bloc_ril_api_login/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(const AuthState()){
    on<RegisterRequested>(
      _onRegisterRequested
    );

    on<LogInRequsted>(
      _onLogInRequested
    );

    on<LogOutRequested>(
      _onLogOutRequested
    );
  }

  Future<void> _onRegisterRequested(RegisterRequested event, Emitter<AuthState> emit)async{
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try{
      await authRepository.register(event.email, event.password);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }catch(e){
      emit(state.copyWith(status: FormzStatus.submissionFailure, messageError: e.toString()));
      throw Exception(e);
    }
  }

  Future<void> _onLogInRequested(LogInRequsted event, Emitter<AuthState> emit)async{
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try{
      await authRepository.logIn(event.email, event.password);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }catch(e){
      emit(state.copyWith(status: FormzStatus.submissionFailure, messageError: e.toString()));
      throw Exception(e);
    }
  }

  Future<void> _onLogOutRequested(LogOutRequested event, Emitter<AuthState> emit)async{
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try{
      await authRepository.logOut();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }catch(e){
      emit(state.copyWith(status: FormzStatus.submissionFailure, messageError: e.toString()));
      throw Exception(e);
    }
  }
}