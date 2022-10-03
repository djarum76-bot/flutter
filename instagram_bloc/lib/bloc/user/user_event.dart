part of 'user_bloc.dart';

abstract class UserEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class UserFetched extends UserEvent{}

class TakePicture extends UserEvent{}

class CompleteProfile extends UserEvent{
  final String phone;
  final String imagePath;

  CompleteProfile(this.phone, this.imagePath);
}