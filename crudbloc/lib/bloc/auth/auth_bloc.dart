import 'package:crudbloc/bloc/auth/auth.dart';
import 'package:crudbloc/repositories/user_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>{
  AuthenticationBloc({required this.userRepositories}) : super(AuthenticationUninitialized());

  final UserRepositories userRepositories;

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event)async*{
    if(event is AppStarted){
      final bool hasToken = await userRepositories.hasToken();
      if(hasToken){
        yield AuthenticationAuthenticated();
      }else{
        yield AuthenticationUnauthenticated();
      }
    }

    if(event is LoggedIn){
      yield AuthenticationLoading();
      await userRepositories.persisteToken(event.token);
      yield AuthenticationAuthenticated();
    }

    if(event is LoggedOut){
      yield AuthenticationLoading();
      await userRepositories.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}