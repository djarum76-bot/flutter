part of 'user_bloc.dart';

class UserState extends Equatable{
  const UserState({
    this.user,
    this.status = FormzStatus.pure,
    this.message
  });

  final UserModel? user;
  final FormzStatus status;
  final String? message;

  UserState copyWith({
    UserModel? user,
    FormzStatus? status,
    String? message
  }) {
    return UserState(
      user: user ?? this.user,
      status: status ?? this.status,
      message: message ?? this.message
    );
  }

  @override
  String toString(){
    return '''UserState { status : $status }''';
  }

  @override
  List<Object?> get props => [user, status];
}