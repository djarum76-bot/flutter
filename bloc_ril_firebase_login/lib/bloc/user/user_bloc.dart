import 'package:bloc_ril_firebase_login/models/user_model.dart';
import 'package:bloc_ril_firebase_login/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  UserBloc({required this.userRepository}) : super(const UserState()){
    on<UserFetched>(
      _onUserFetched
    );
  }

  final UserRepository userRepository;

  Future<void> _onUserFetched(UserFetched event, Emitter<UserState> emit)async{
    try{
      final userModel = await userRepository.getUser(event.uid);
      emit(state.copyWith(
        userModel: userModel,
        userStatus: UserStatus.success
      ));
    }catch(e){
      emit(state.copyWith(userStatus: UserStatus.failure));
      throw Exception(e);
    }
  }
}