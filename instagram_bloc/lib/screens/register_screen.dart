import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:instagram_bloc/bloc/auth/auth_bloc.dart';
import 'package:instagram_bloc/components/scaffold_message.dart';
import 'package:instagram_bloc/cubit/password_cubit.dart';
import 'package:formz/formz.dart';
import 'package:instagram_bloc/utils/routes.dart';

class RegisterScreen extends StatefulWidget{
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _username;
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _username = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _username.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => PasswordCubit(),
        child: _registerView(context),
      ),
    );
  }

  Widget _registerView(BuildContext context){
    final size = MediaQuery.of(context).size;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state){
        if(state.status == AuthStatus.autherror){
          scaffoldMessage(context, state.message ?? "Error");
        }
        if(state.status == AuthStatus.authenticatedNoPic){
          Navigator.pushNamedAndRemoveUntil(context, Routes.completeProfileScreen, (route) => false);
        }
      },
      child: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              _formInput(context),
              SizedBox(height: 20,),
              _goToLogin()
            ],
          ),
        ),
      ),
    );
  }

  Widget _formInput(BuildContext context){
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _usernameInput(),
          SizedBox(height: 5,),
          _emailInput(),
          SizedBox(height: 5,),
          _passwordInput(),
          SizedBox(height: 10,),
          _registerButton(context)
        ],
      ),
    );
  }

  Widget _usernameInput(){
    return TextFormField(
      decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: "Username"
      ),
      controller: _username,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: ValidationBuilder().build(),
    );
  }

  Widget _emailInput(){
    return TextFormField(
      decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: "Email"
      ),
      controller: _email,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: ValidationBuilder().email("Invalid email").build(),
    );
  }

  Widget _passwordInput(){
    return BlocBuilder<PasswordCubit, bool>(
      builder: (context,state){
        return TextFormField(
          decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: "Password",
              suffixIcon: IconButton(
                onPressed: (){
                  context.read<PasswordCubit>().changeObscure();
                },
                icon: Icon(state ? Icons.visibility_off : Icons.visibility),
              )
          ),
          controller: _password,
          obscureText: state,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: ValidationBuilder().minLength(8, "Enter min 8 Characted").build(),
        );
      },
    );
  }

  Widget _registerButton(BuildContext context){
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state){
        return state.status == AuthStatus.loading
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: (){
                  _registerButtonFunction(context);
                },
                child: Text("Register"),
              );
      },
    );
  }

  void _registerButtonFunction(BuildContext context){
    if(_formKey.currentState!.validate()){
      BlocProvider.of<AuthBloc>(context).add(
          RegisterRequested(_username.text, _email.text, _password.text)
      );
    }
  }

  Widget _goToLogin(){
    return TextButton(
      onPressed: (){
        Navigator.pop(context);
      },
      child: Text("Login"),
    );
  }
}