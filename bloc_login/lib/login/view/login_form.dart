import 'package:bloc_login/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget{
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state){
        if(state.status.isSubmissionFailure){
          ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text("Autentikasi Gagal"))
              );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1/3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _UsernameInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _PasswordInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _LoginButton()
          ],
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prev, curr){
        return prev.username != curr.username;
      },
      builder: (context, state){
        return TextField(
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (username){
            context.read<LoginBloc>().add(LoginUsernameChanged(username));
          },
          decoration: InputDecoration(
            labelText: "Username",
            errorText: state.username.invalid ? "Invalid Username" : null
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prev, curr){
        return prev.password != curr.password;
      },
      builder: (context, state){
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password){
            context.read<LoginBloc>().add(LoginPasswordChanged(password));
          },
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Password",
            errorText: state.password.invalid ? "Invalid Password" : null
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prev, curr){
        return prev.status != curr.status;
      },
      builder: (context, state){
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                  key: const Key('loginForm_continue_raisedButton'),
                  onPressed: state.status.isValidated
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      }
                    : null,
                  child: const Text("Login")
              );
      },
    );
  }
}