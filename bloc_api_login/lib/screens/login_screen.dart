import 'package:bloc_api_login/cubit/login.dart';
import 'package:bloc_api_login/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginScreen extends StatelessWidget{
  const LoginScreen({super.key});

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
          Navigator.pushNamedAndRemoveUntil(context, Routes.navbarScreen, (route) => false);
        }
      },
      child: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.symmetric(horizontal: 20),
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
                SizedBox(height: 20,),
                TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, Routes.registerScreen);
                    },
                    child: Text("Register")
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
      builder: (context, state){
        return TextFormField(
          onChanged: (value) => context.read<LoginCubit>().emailChanged(value),
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            labelText: "Email",
            errorText: state.email.invalid ? "Invalid Email" : null
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
          onChanged: (value) => context.read<LoginCubit>().passwordChanged(value),
          decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: "Password",
              errorText: state.password.invalid ? "Invalid Password" : null,
              suffixIcon: IconButton(
                onPressed: (){
                  context.read<LoginCubit>().obscureChanged(!state.obscure);
                },
                icon: Icon(state.obscure ? Icons.visibility_off : Icons.visibility),
              )
          ),
          obscureText: state.obscure,
          keyboardType: TextInputType.emailAddress,
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