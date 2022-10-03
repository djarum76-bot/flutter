import 'package:bloc_firebase_login/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LogOutState extends Equatable{
  const LogOutState({
    this.status = FormzStatus.pure
  });

  final FormzStatus status;

  @override
  List<Object?> get props => [status];

  LogOutState copyWith({
    FormzStatus? status
  }) {
    return LogOutState(
      status: status ?? this.status
    );
  }
}

class LogOutCubit extends Cubit<LogOutState>{
  LogOutCubit() : super(const LogOutState());

  final AuthRepository _authRepository = AuthRepository();

  Future<void> logOut()async{
    try{
      await _authRepository.logOut();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }on Exception{
      throw LogOutFailure();
    }
  }
}