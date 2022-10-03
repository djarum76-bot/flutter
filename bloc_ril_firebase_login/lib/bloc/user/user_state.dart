part of 'user_bloc.dart';

enum UserStatus { initial, success, failure }

class UserState extends Equatable{
  const UserState({
    this.userStatus = UserStatus.initial,
    this.userModel
  });

  final UserStatus userStatus;
  final UserModel? userModel;

  @override
  List<Object?> get props => [userStatus, userModel];

  UserState copyWith({
    UserStatus? userStatus,
    UserModel? userModel
  }) {
    return UserState(
      userStatus: userStatus ?? this.userStatus,
      userModel: userModel ?? this.userModel
    );
  }

  @override
  String toString(){
    return '''UserState { status : $userStatus }''';
  }
}