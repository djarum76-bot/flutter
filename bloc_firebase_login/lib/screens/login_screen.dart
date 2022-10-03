import 'package:bloc_firebase_login/cubit/login.dart';
import 'package:bloc_firebase_login/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => LoginCubit(),
        child: Scaffold(
          body: _loginView(context),
        ),
    );
  }

  Widget _loginView(BuildContext context){
    final size = MediaQuery.of(context).size;
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state){
        if(state.status.isSubmissionFailure){
          ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(state.errorMessage ?? "Authentication Failure"))
              );
        }

        if(state.status.isSubmissionSuccess){
          Navigator.pushNamedAndRemoveUntil(context, Routes.profileScreen, (route) => false);
        }
      },
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: size.width,
          height: size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _loginEmailInput(),
                SizedBox(height: 10,),
                _loginPasswordInput(),
                SizedBox(height: 20,),
                _loginButton(),
                SizedBox(height: 30,),
                TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, Routes.registerScreen);
                  },
                  child: Text("Register"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginEmailInput(){
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (prev,curr) => prev.email != curr.email,
      builder: (context, state){
        return TextFormField(
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            labelText: "Email",
            errorText: state.email.invalid ? "Invalid email" : null
          ),
          keyboardType: TextInputType.emailAddress,
        );
      },
    );
  }

  Widget _loginPasswordInput(){
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state){
        return TextFormField(
          onChanged: (password) => context.read<LoginCubit>().passwordChanged(password),
          decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: "Password",
              errorText: state.password.invalid ? "Invalid password" : null,
              suffixIcon: IconButton(
                icon: Icon(state.obscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  context.read<LoginCubit>().obscureChanged(!state.obscure);
                },
              )
          ),
          obscureText: state.obscure,
          keyboardType: TextInputType.name,
        );
      },
    );
  }

  Widget _loginButton(){
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state){
        return state.status.isSubmissionInProgress
            ? CircularProgressIndicator()
            : ElevatedButton(
                  onPressed: (){
                    context.read<LoginCubit>().submit();
                  },
                  child: Text("Login")
              );
      },
    );
  }
}