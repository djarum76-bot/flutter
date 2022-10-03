part of 'user_bloc.dart';

class UserState extends Equatable{
  const UserState({
    this.userModel,
    this.status = FormzStatus.pure,
    this.image,
    this.message
  });

  final UserModel? userModel;
  final FormzStatus status;
  final String? image;
  final String? message;

  @override
  List<Object?> get props => [userModel, status, image];

  UserState copyWith({
    UserModel? userModel,
    FormzStatus? status,
    String? image,
    String? message
  }) {
    return UserState(
      userModel: userModel ?? this.userModel,
      status: status ?? this.status,
      image: image ?? this.image,
      message: message ?? this.message
    );
  }

  @override
  String toString(){
    return '''UserState { status : $status }''';
  }
}