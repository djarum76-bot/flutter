part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class RegisterRequested extends AuthEvent{
  final String email;
  final String password;

  RegisterRequested(this.email, this.password);
}

class LogInRequsted extends AuthEvent{
  final String email;
  final String password;

  LogInRequsted(this.email, this.password);
}

class LogOutRequested extends AuthEvent{}