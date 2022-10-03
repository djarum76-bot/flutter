import 'package:bloc_api_login/cubit/register.dart';
import 'package:bloc_api_login/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class RegisterScreen extends StatelessWidget{
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(),
      child: Scaffold(
        body: _registerView(context),
      ),
    );
  }

  Widget _registerView(BuildContext context){
    final size = MediaQuery.of(context).size;
    return BlocListener<RegisterCubit, RegisterState>(
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
                _registerEmailInput(),
                SizedBox(height: 10,),
                _registerPasswordInput(),
                SizedBox(height: 20,),
                _registerButton(),
                SizedBox(height: 20,),
                TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text("Login")
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerEmailInput(){
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state){
        return TextFormField(
          onChanged: (value) => context.read<RegisterCubit>().emailChanged(value),
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

  Widget _registerPasswordInput(){
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state){
        return TextFormField(
          onChanged: (value) => context.read<RegisterCubit>().passwordChanged(value),
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            labelText: "Password",
            errorText: state.password.invalid ? "Invalid Password" : null,
            suffixIcon: IconButton(
              onPressed: (){
                context.read<RegisterCubit>().obscureChanged(!state.obscure);
              },
              icon: Icon(state.obscure ? Icons.visibility_off : Icons.visibility),
            )
          ),
          obscureText: state.obscure,
          keyboardType: TextInputType.name,
        );
      },
    );
  }

  Widget _registerButton(){
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state){
        return state.status.isSubmissionInProgress
            ? CircularProgressIndicator()
            : ElevatedButton(
                  onPressed: (){
                    context.read<RegisterCubit>().submit();
                  },
                  child: Text("Register")
              );
      },
    );
  }
}