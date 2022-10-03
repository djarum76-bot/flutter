import 'package:bloc_ril_firebase_login/bloc/auth/auth_bloc.dart';
import 'package:bloc_ril_firebase_login/bloc/user/user_bloc.dart';
import 'package:bloc_ril_firebase_login/repositories/user_repository.dart';
import 'package:bloc_ril_firebase_login/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatelessWidget{
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state){
          if(state is UnAuthenticated){
            Navigator.pushNamedAndRemoveUntil(context, Routes.signInScreen, (route) => false);
          }
        },
        builder: (context, state){
          if(state is Loading){
            return Center(child: CircularProgressIndicator(),);
          }
          return SafeArea(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocProvider(
                    create: (_) => UserBloc(userRepository: RepositoryProvider.of<UserRepository>(context))..add(UserFetched(FirebaseAuth.instance.currentUser!.uid)),
                    child: BlocBuilder<UserBloc, UserState>(
                      builder: (context, state){
                        if(state.userStatus == UserStatus.failure){
                          return Text("gagal");
                        }
                        if(state.userStatus == UserStatus.success){
                          return Text(state.userModel!.username!);
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ),
                  IconButton(
                      onPressed: (){
                        BlocProvider.of<AuthBloc>(context).add(
                          SignOutRequested()
                        );
                      },
                      icon: Icon(Icons.logout)
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}