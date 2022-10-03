import 'package:bloc_ril_firebase_login/repositories/auth_repository.dart';
import 'package:bloc_ril_firebase_login/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  final AuthRepository authRepository;
  final UserRepository userRepository;

  AuthBloc({required this.authRepository, required this.userRepository}) : super(UnAuthenticated()){
    on<SignInRequested>((event, emit)async{
      emit(Loading());
      try{
        await authRepository.signIn(event.email, event.password);
        emit(Authenticated());
      }catch(e){
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });

    on<SignUpRequested>((event, emit)async{
      emit(Loading());
      try{
        await authRepository.signUp(event.email, event.password);
        final currUser = FirebaseAuth.instance.currentUser;
        await userRepository.createUser(currUser!.uid, event.username, event.email);
        emit(Authenticated());
      }catch(e){
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });

    on<GoogleSignInRequested>((event, emit)async{
      emit(Loading());
      try{
        await authRepository.signInWithGoogle();
        emit(Authenticated());
      }catch(e){
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });

    on<SignOutRequested>((event, emit)async{
      emit(Loading());
      await authRepository.signOut();
      emit(UnAuthenticated());
    });
  }
}