import 'package:bloc_api_login/cubit/logout.dart';
import 'package:bloc_api_login/cubit/user.dart';
import 'package:bloc_api_login/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class ProfileScreen extends StatelessWidget{
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UserCubit(),
        ),
        BlocProvider(
          create: (_) => LogOutCubit(),
        )
      ],
      child: Scaffold(
        body: _profileBody(context),
      ),
    );
  }

  Widget _profileBody(BuildContext context){
    final size = MediaQuery.of(context).size;
    return BlocListener<LogOutCubit, LogOutState>(
      listener: (context, state){
        if(state.status.isSubmissionFailure){
          ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text("Error cok"))
              );
        }

        if(state.status.isSubmissionSuccess){
          Navigator.pushNamedAndRemoveUntil(context, Routes.splashScreen, (route) => false);
        }
      },
      child: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              _emailProfile(),
              SizedBox(height: 30,),
              _logOutButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailProfile(){
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state){
        if(state.userModel != null){
          return Text(
            state.userModel!.data!.email!,
            style: TextStyle(fontSize: 26),
          );
        }else{
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _logOutButton(BuildContext context){
    return BlocBuilder<LogOutCubit, LogOutState>(
      builder: (context, state){
        if(state.status.isSubmissionInProgress){
          return CircularProgressIndicator();
        }else{
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
                onPressed: (){
                  context.read<LogOutCubit>().logOut();
                },
                child: Text("LOGOUT")
            ),
          );
        }
      },
    );
  }
}