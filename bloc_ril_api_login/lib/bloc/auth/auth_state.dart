part of 'auth_bloc.dart';

class AuthState extends Equatable{
  const AuthState({
    this.status = FormzStatus.pure,
    this.messageError
  });

  final FormzStatus status;
  final String? messageError;

  @override
  List<Object?> get props => [status];

  AuthState copyWith({
    FormzStatus? status,
    String? messageError
  }) {
    return AuthState(
      status: status ?? this.status,
      messageError: messageError ?? this.messageError
    );
  }

  @override
  String toString(){
    return '''AuthState { status : $status }''';
  }
}