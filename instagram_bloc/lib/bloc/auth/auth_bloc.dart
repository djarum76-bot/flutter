import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:instagram_bloc/repositories/auth_repository.dart';
import 'package:instagram_bloc/repositories/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  final AuthRepository authRepository;
  final UserRepository userRepository;

  AuthBloc({required this.authRepository, required this.userRepository}) : super(const AuthState()) {
    on<RegisterRequested>(
      _onRegisterRequested
    );
    on<LogInRequested>(
      _onLogInRequested
    );
    on<LogOutRequested>(
      _onLogOutRequested
    );
  }

  Future<void> _onRegisterRequested(RegisterRequested event, Emitter<AuthState> emit)async{
    emit(state.copyWith(status: AuthStatus.loading));
    try{
      await authRepository.register(event.username, event.email, event.password);
      emit(state.copyWith(
        status: AuthStatus.authenticatedNoPic
      ));
    }catch(e){
      emit(state.copyWith(
        status: AuthStatus.autherror,
        message: e.toString()
      ));
      throw Exception(e);
    }
  }

  Future<void> _onLogInRequested(LogInRequested event, Emitter<AuthState> emit)async{
    emit(state.copyWith(status: AuthStatus.loading));
    try{
      await authRepository.logIn(event.email, event.password);
      final userModel = await userRepository.getUser();
      if(userModel.phone!.valid!){
        emit(state.copyWith(
            status: AuthStatus.authenticated
        ));
      }else{
        emit(state.copyWith(
            status: AuthStatus.authenticatedNoPic
        ));
      }
    }catch(e){
      emit(state.copyWith(
        message: e.toString(),
        status: AuthStatus.autherror
      ));
      throw Exception(e);
    }
  }

  Future<void> _onLogOutRequested(LogOutRequested event, Emitter<AuthState> emit)async{
    emit(state.copyWith(status: AuthStatus.loading));
    try{
      await authRepository.logOut();
      emit(state.copyWith(
        status: AuthStatus.unauthenticated
      ));
    }catch(e){
      emit(state.copyWith(
        message: e.toString(),
        status: AuthStatus.autherror
      ));
      throw Exception(e);
    }
  }
}