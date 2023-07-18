part of 'user_bloc.dart';

abstract class UserEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class UserRegister extends UserEvent{
  final String email;
  final String password;

  UserRegister(this.email, this.password);
}

class UserLogin extends UserEvent{
  final String email;
  final String password;

  UserLogin(this.email, this.password);
}

class UserLogout extends UserEvent{}

class UserFetched extends UserEvent{}

class UserUpdated extends UserEvent{}