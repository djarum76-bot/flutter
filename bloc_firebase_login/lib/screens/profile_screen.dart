import 'package:bloc_firebase_login/cubit/logout.dart';
import 'package:bloc_firebase_login/cubit/profile.dart';
import 'package:bloc_firebase_login/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProfileCubit(),
        ),
        BlocProvider(
          create: (_) => LogOutCubit(),
        )
      ],
      child: Scaffold(
        body: _profileView(context),
      ),
    );
  }

  Widget _profileView(BuildContext context){
    final size = MediaQuery.of(context).size;
    return  MultiBlocListener(
      listeners: [
        BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state){
            if(state.status.isSubmissionFailure){
              Navigator.pushNamedAndRemoveUntil(context, Routes.completeProfileScreen, (route) => false);
            }
          },
        ),
        BlocListener<LogOutCubit, LogOutState>(
          listener: (context, state){
            if(state.status.isSubmissionFailure){
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                    SnackBar(content: Text("Fail to log out"))
                );
            }

            if(state.status.isSubmissionSuccess){
              Navigator.pushNamedAndRemoveUntil(context, Routes.splashScreen, (route) => false);
            }
          },
        )
      ],
      child: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _nameProfile(),
                _logOutButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _nameProfile(){
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state){
        if(state.userModel != null){
          return Text(
            state.userModel!.name!
          );
        }else{
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _logOutButton(){
    return BlocBuilder<LogOutCubit, LogOutState>(
      builder: (context, state){
        return state.status.isSubmissionInProgress
            ? CircularProgressIndicator()
            : IconButton(
                onPressed: (){
                  context.read<LogOutCubit>().logOut();
                },
                icon: Icon(Icons.logout),
              );
      },
    );
  }
}