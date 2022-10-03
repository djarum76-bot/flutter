import 'package:bloc_api_login/repositories/auth_repository.dart';
import 'package:bloc_api_login/utils/validators/validators.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class RegisterState extends Equatable{
  const RegisterState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.obscure = true,
    this.errorMessage
  });

  final Email email;
  final Password password;
  final FormzStatus status;
  final bool obscure;
  final String? errorMessage;

  @override
  List<Object?> get props => [email, password, status, obscure];

  RegisterState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    bool? obscure,
    String? errorMessage
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      obscure: obscure ?? this.obscure,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
}

class RegisterCubit extends Cubit<RegisterState>{
  RegisterCubit() : super(const RegisterState());

  final _authRepository = AuthRepository();

  void emailChanged(String value){
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.password
      ])
    ));
  }

  void passwordChanged(String value){
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([
        state.email,
        password
      ])
    ));
  }

  void obscureChanged(bool value){
    emit(state.copyWith(
      obscure: value
    ));
  }

  Future<void> submit()async{
    if(!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try{
      await _authRepository.register(state.email.value, state.password.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }on RegisterFailure catch(e){
      emit(state.copyWith(
        errorMessage: e.message,
        status: FormzStatus.submissionFailure
      ));
    }catch(_){
      emit(state.copyWith(
        status: FormzStatus.submissionFailure
      ));
    }
  }
}