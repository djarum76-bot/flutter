import 'package:bloc_api_login/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LogOutState extends Equatable{
  const LogOutState({
    this.status = FormzStatus.pure
  });

  final FormzStatus status;

  @override
  // TODO: implement props
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

  final _authRepository = AuthRepository();

  Future<void> logOut()async{
    try{
      await _authRepository.logOut();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }on Exception{
      emit(state.copyWith(status: FormzStatus.submissionFailure));
      throw LogOutFailure();
    }
  }
}