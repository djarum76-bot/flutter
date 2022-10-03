import 'package:bloc_firebase_login/cubit/register.dart';
import 'package:bloc_firebase_login/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget{
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
          Navigator.pushNamedAndRemoveUntil(context, Routes.completeProfileScreen, (route) => false);
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
                _registerEmailInput(),
                SizedBox(height: 10,),
                _registerPasswordInput(),
                SizedBox(height: 10,),
                _registerConfirmPasswordInput(),
                SizedBox(height: 20,),
                _registerButton(),
                SizedBox(height: 30,),
                TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("Login"),
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
          onChanged: (email) => context.read<RegisterCubit>().emailChanged(email),
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
          onChanged: (password) => context.read<RegisterCubit>().passwordChanged(password),
          decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: "Pasword",
              errorText: state.password.invalid ? "Invalid Password" : null,
              suffixIcon: IconButton(
                icon: Icon(state.obscurePassword ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  context.read<RegisterCubit>().obscurePasswordChanged(!state.obscurePassword);
                },
              )
          ),
          obscureText: state.obscurePassword,
          keyboardType: TextInputType.name,
        );
      },
    );
  }

  Widget _registerConfirmPasswordInput(){
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state){
        return TextFormField(
          onChanged: (confirmPassword) => context.read<RegisterCubit>().confirmedPasswordChanged(confirmPassword),
          decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: "Confirm Pasword",
              errorText: state.confirmedPassword.value == "" ? null : state.confirmedPassword.invalid ? "Password Not Match" : null,
              suffixIcon: IconButton(
                icon: Icon(state.obscureConfPassword ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  context.read<RegisterCubit>().obscureConfirmPasswordChanged(!state.obscureConfPassword);
                },
              )
          ),
          obscureText: state.obscureConfPassword,
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