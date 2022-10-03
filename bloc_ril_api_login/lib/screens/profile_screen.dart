import 'package:bloc_ril_api_login/bloc/auth/auth_bloc.dart';
import 'package:bloc_ril_api_login/bloc/user/user_bloc.dart';
import 'package:bloc_ril_api_login/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class ProfileScreen extends StatelessWidget{
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state){
          if(state.status.isSubmissionFailure){
            ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                    SnackBar(content: Text(state.messageError ?? "Error"))
                );
          }

          if(state.status.isSubmissionSuccess){
            Navigator.pushNamedAndRemoveUntil(context, Routes.logInScreen, (route) => false);
          }
        },
        child: _profileView(context),
      ),
    );
  }

  Widget _profileView(BuildContext context){
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _emailProfile(),
              SizedBox(height: 10,),
              _logOutButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailProfile(){
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state){
        if(state.status.isSubmissionFailure){
          return Text("email");
        }
        if(state.status.isSubmissionSuccess){
          return Text(state.user!.data!.email!);
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget _logOutButton(BuildContext context){
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state){
        return state.status.isSubmissionInProgress
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: (){
                  _logOutButtonFunction(context);
                },
                child: Text("Log Out"),
              );
      },
    );
  }

  void _logOutButtonFunction(BuildContext context){
    BlocProvider.of<AuthBloc>(context).add(
      LogOutRequested()
    );
  }
}