import 'package:bloc_firebase_login/repositories/auth_repository.dart';
import 'package:bloc_firebase_login/utils/validators/validators.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginState extends Equatable{
  const LoginState({
    this.email = const EmailValidator.pure(),
    this.password = const PasswordValidator.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.obscure = true
  });

  final EmailValidator email;
  final PasswordValidator password;
  final FormzStatus status;
  final String? errorMessage;
  final bool obscure;

  @override
  List<Object?> get props => [email, password, status, obscure];

  LoginState copyWith({
    EmailValidator? email,
    PasswordValidator? password,
    FormzStatus? status,
    String? errorMessage,
    bool? obscure
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      obscure: obscure ?? this.obscure
    );
  }
}

class LoginCubit extends Cubit<LoginState>{
  LoginCubit() : super(const LoginState());

  final AuthRepository _authRepository = AuthRepository();

  void emailChanged(String value){
    final email = EmailValidator.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.password])
    ));
  }

  void passwordChanged(String value){
    final password = PasswordValidator.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.email, password])
    ));
  }

  void obscureChanged(bool value){
    final obscure = value;
    emit(state.copyWith(
      obscure: obscure
    ));
  }

  Future<void> submit()async{
    if(!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try{
      await _authRepository.logIn(state.email.value, state.password.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }on LogInFailure catch(e){
      emit(state.copyWith(
        errorMessage: e.message,
        status: FormzStatus.submissionFailure
      ));
    }catch(_){
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}