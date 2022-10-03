import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_bloc/bloc/auth/auth_bloc.dart';
import 'package:instagram_bloc/bloc/user/user_bloc.dart';
import 'package:instagram_bloc/components/scaffold_message.dart';
import 'package:instagram_bloc/repositories/user_repository.dart';
import 'package:instagram_bloc/utils/constants.dart';
import 'package:instagram_bloc/utils/routes.dart';

class ProfileScreen extends StatelessWidget{
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => UserBloc(userRepository: RepositoryProvider.of<UserRepository>(context))..add(UserFetched()),
        child: _profileView(context),
      ),
    );
  }

  Widget _profileView(BuildContext context){
    final size = MediaQuery.of(context).size;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state){
        if(state.status == AuthStatus.autherror){
          scaffoldMessage(context, state.message ?? "Error");
        }
        if(state.status == AuthStatus.unauthenticated){
          Navigator.pushNamedAndRemoveUntil(context, Routes.loginScreen, (route) => false);
        }
      },
      child: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              _userData(),
              SizedBox(height: 40,),
              _logOutButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _userData(){
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state){
        if(state.userModel == null){
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: CircleAvatar(
                  radius: 40,
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("nama"),
                    Text("email"),
                    Text("no hp"),
                  ],
                ),
              )
            ],
          );
        }else{
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 1,
                  child: state.userModel!.picture!.valid!
                      ? _picture(state)
                      : _noPicture()
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(state.userModel!.username!),
                    Text(state.userModel!.email!),
                    Text(state.userModel!.phone!.valid! ? state.userModel!.phone!.string! : ""),
                  ],
                ),
              )
            ],
          );
        }
      },
    );
  }

  Widget _noPicture(){
    return CircleAvatar(
      backgroundImage: AssetImage("asset/download.png"),
      radius: 40,
    );
  }

  Widget _picture(UserState state){
    return CircleAvatar(
      backgroundImage: NetworkImage("${Constants.baseURL}/${state.userModel!.picture!.string!}"),
      radius: 40,
    );
  }

  Widget _logOutButton(BuildContext context){
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state){
        return state.status == AuthStatus.loading
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