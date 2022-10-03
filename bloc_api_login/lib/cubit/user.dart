import 'package:bloc_api_login/models/user_model.dart';
import 'package:bloc_api_login/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserState extends Equatable{
  const UserState({
    this.userModel,
  });

  final UserModel? userModel;

  @override
  List<Object?> get props => [userModel];

  UserState copyWith({
    UserModel? userModel
  }) {
    return UserState(
      userModel: userModel ?? this.userModel,
    );
  }
}

class UserCubit extends Cubit<UserState>{
  UserCubit() : super(const UserState()){
    _userRepository = UserRepository();

    Future.wait([getUser()]);
  }

  late UserRepository _userRepository;

  Future<void> getUser()async{
    try{
      final userModel = await _userRepository.getUser();
      emit(state.copyWith(userModel: userModel));
    }catch(e){
      throw Exception(e);
    }
  }
}