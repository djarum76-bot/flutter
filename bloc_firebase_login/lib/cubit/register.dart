import 'package:bloc_firebase_login/repositories/auth_repository.dart';
import 'package:bloc_firebase_login/utils/validators/validators.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class RegisterState extends Equatable{
  const RegisterState({
    this.email = const EmailValidator.pure(),
    this.password = const PasswordValidator.pure(),
    this.confirmedPassword = const ConfirmPasswordValidator.pure(),
    this.status = FormzStatus.pure,
    this.obscurePassword = true,
    this.obscureConfPassword = true,
    this.errorMessage
  });

  final EmailValidator email;
  final PasswordValidator password;
  final ConfirmPasswordValidator confirmedPassword;
  final FormzStatus status;
  final bool obscurePassword;
  final bool obscureConfPassword;
  final String? errorMessage;

  @override
  List<Object?> get props => [email, password, confirmedPassword, status, obscurePassword, obscureConfPassword];

  RegisterState copyWith({
    EmailValidator? email,
    PasswordValidator? password,
    ConfirmPasswordValidator? confirmedPassword,
    FormzStatus? status,
    bool? obscurePassword,
    bool? obscureConfPassword,
    String? errorMessage
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfPassword: obscureConfPassword ?? this.obscureConfPassword,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
}

class RegisterCubit extends Cubit<RegisterState>{
  RegisterCubit() : super(const RegisterState());

  final AuthRepository _authRepository = AuthRepository();

  void emailChanged(String value){
    final email = EmailValidator.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.password,
        state.confirmedPassword
      ])
    ));
  }

  void passwordChanged(String value){
    final password = PasswordValidator.dirty(value);
    final confirmedPassword = ConfirmPasswordValidator.dirty(
      password: password.value,
      value: state.confirmedPassword.value
    );
    emit(state.copyWith(
      password: password,
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.email,
        password,
        confirmedPassword
      ])
    ));
  }

  void obscurePasswordChanged(bool value){
    final obscurePassword = value;
    emit(state.copyWith(
      obscurePassword: obscurePassword
    ));
  }

  void confirmedPasswordChanged(String value){
    final confirmedPassword = ConfirmPasswordValidator.dirty(
      password: state.password.value,
      value: value
    );
    emit(state.copyWith(
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.email,
        state.password,
        confirmedPassword
      ])
    ));
  }

  void obscureConfirmPasswordChanged(bool value){
    final obscureConfPassword = value;
    emit(state.copyWith(
        obscureConfPassword: obscureConfPassword
    ));
  }

  Future<void> submit()async{
    if(!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try{
      await _authRepository.signUp(state.email.value, state.password.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }on LogInFailure catch(e){
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