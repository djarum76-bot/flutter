import 'package:bloc_firebase_login/models/user_model.dart';
import 'package:bloc_firebase_login/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class ProfileState extends Equatable{
  const ProfileState({
    this.authUser,
    this.userModel,
    this.status = FormzStatus.pure
  });

  final User? authUser;
  final UserModel? userModel;
  final FormzStatus status;

  @override
  List<Object?> get props => [authUser, userModel, status];

  ProfileState copyWith({
    User? authUser,
    UserModel? userModel,
    FormzStatus? status
  }) {
    return ProfileState(
      authUser: authUser ?? this.authUser,
      userModel: userModel ?? this.userModel,
      status: status ?? this.status
    );
  }
}

class ProfileCubit extends Cubit<ProfileState>{
  ProfileCubit() : super(const ProfileState()){
    _userRepository = UserRepository();

    Future.wait([getAuthProfile(), getProfile()]);
  }

  late UserRepository _userRepository;

  Future<void> getAuthProfile()async{
    try{
      final authUser = FirebaseAuth.instance.currentUser;
      emit(state.copyWith(authUser: authUser));
    }catch (e){
      throw Exception(e);
    }
  }

  Future<void> getProfile()async{
    try{
      final userModel = await _userRepository.getUserById(state.authUser!.uid);
      emit(state.copyWith(userModel: userModel));
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }catch (e){
      emit(state.copyWith(status: FormzStatus.submissionFailure));
      throw Exception(e);
    }
  }
}