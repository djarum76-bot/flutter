part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class RegisterRequested extends AuthEvent{
  final String username;
  final String email;
  final String password;

  RegisterRequested(this.username, this.email, this.password);
}

class LogInRequested extends AuthEvent{
  final String email;
  final String password;

  LogInRequested(this.email, this.password);
}

class LogOutRequested extends AuthEvent{}