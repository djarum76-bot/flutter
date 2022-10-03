import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:instagram_bloc/bloc/auth/auth_bloc.dart';
import 'package:instagram_bloc/components/scaffold_message.dart';
import 'package:instagram_bloc/cubit/password_cubit.dart';
import 'package:instagram_bloc/utils/routes.dart';
import 'package:formz/formz.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => PasswordCubit(),
        child: _loginView(context),
      ),
    );
  }

  Widget _loginView(BuildContext context){
    final size = MediaQuery.of(context).size;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state){
        if(state.status == AuthStatus.autherror){
          scaffoldMessage(context, state.message ?? "Error");
        }

        if(state.status == AuthStatus.authenticated){
          Navigator.pushNamedAndRemoveUntil(context, Routes.navbarScreen, (route) => false);
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
              _goToRegister()
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
          _emailInput(),
          SizedBox(height: 5,),
          _passwordInput(),
          SizedBox(height: 10,),
          _loginButton(context)
        ],
      ),
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

  Widget _loginButton(BuildContext context){
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state){
        return state.status == AuthStatus.loading
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: (){
                  _loginButtonFunction(context);
                },
                child: Text("Login"),
              );
      },
    );
  }

  void _loginButtonFunction(BuildContext context){
    if(_formKey.currentState!.validate()){
      BlocProvider.of<AuthBloc>(context).add(
        LogInRequested(_email.text, _password.text)
      );
    }
  }

  Widget _goToRegister(){
    return TextButton(
      onPressed: (){
        Navigator.pushNamed(context, Routes.registerScreen);
      },
      child: Text("Register"),
    );
  }
}