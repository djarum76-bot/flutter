import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nonolep/models/user_model.dart';
import 'package:nonolep/repositories/user_repository.dart';
import 'package:nonolep/services/local/local_storage.dart';
import 'package:nonolep/utils/constants/local_constant.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(const UserState()) {
    on<UserRegister>(_onUserRegister);
    on<UserLogin>(_onUserLogin);
    on<UserLogout>(_onUserLogout);
    on<UserFetched>(_onUserFetched);
    on<UserUpdated>(_onUserUpdated);
  }

  Future<void> _onUserRegister(UserRegister event, Emitter<UserState> emit)async{
    emit(state.copyWith(status: UserStatus.loading));

    final apiResponse = await userRepository.register(event.email, event.password);
    if(apiResponse.error){
      emit(state.copyWith(
        status: UserStatus.error,
        message: apiResponse.message
      ));
    }else{
      final storage = LocalStorage.instance;

      await storage.setData<String>(LocalConstant.token, apiResponse.data!).then((value){
        emit(state.copyWith(status: UserStatus.authenticated));
      });
    }
  }

  Future<void> _onUserLogin(UserLogin event, Emitter<UserState> emit)async{
    emit(state.copyWith(status: UserStatus.loading));

    final apiResponse = await userRepository.login(event.email, event.password);
    if(apiResponse.error){
      emit(state.copyWith(
        status: UserStatus.error,
        message: apiResponse.message
      ));
    }else{
      final storage = LocalStorage.instance;

      await storage.setData<String>(LocalConstant.token, apiResponse.data!).then((value){
        emit(state.copyWith(status: UserStatus.authenticated));
      });
    }
  }

  Future<void> _onUserLogout(UserLogout event, Emitter<UserState> emit)async{
    emit(state.copyWith(status: UserStatus.loading));

    final storage = LocalStorage.instance;

    await storage.deleteData().then((value){
      emit(state.copyWith(status: UserStatus.unauthenticated));
    });
  }

  Future<void> _onUserFetched(UserFetched event, Emitter<UserState> emit)async{
    emit(state.copyWith(status: UserStatus.loading));

    final apiResponse = await userRepository.getUser();
    final storage = LocalStorage.instance;
    if(apiResponse.error){
      final user = await storage.user;

      emit(state.copyWith(
        status: UserStatus.error,
        message: apiResponse.message,
        user: user
      ));
    }else{
      await storage.setData<UserModel>(LocalConstant.user, apiResponse.data!).then((value){
        emit(state.copyWith(
          status: UserStatus.fetched,
          user: apiResponse.data
        ));
      });
    }
  }

  Future<void> _onUserUpdated(UserUpdated event, Emitter<UserState> emit)async{
    emit(state.copyWith(status: UserStatus.loading));

    final storage = LocalStorage.instance;
    final user = await storage.user;

    final apiResponse = await userRepository.updateUser(user: user);
    if(apiResponse.error){
      emit(state.copyWith(
        status: UserStatus.error,
        message: apiResponse.message
      ));
    }else{
      emit(state.copyWith(status: UserStatus.updated));
    }
  }
}
