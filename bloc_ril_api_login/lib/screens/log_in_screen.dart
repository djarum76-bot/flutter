import 'package:bloc_ril_api_login/bloc/auth/auth_bloc.dart';
import 'package:bloc_ril_api_login/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:formz/formz.dart';

class LogInScreen extends StatefulWidget{
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
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
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state){
            if(state.status.isSubmissionFailure){
              ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text(state.messageError ?? "Error"))
                  );
            }

            if(state.status.isSubmissionSuccess){
              Navigator.pushNamedAndRemoveUntil(context, Routes.navbarScreen, (route) => false);
            }
          },
          child: _logInView(context),
        ),
      ),
    );
  }

  Widget _logInView(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.all(10),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _formLogIn(context),
              SizedBox(height: 10,),
              _goToRegister()
            ],
          ),
        ),
      ),
    );
  }

  Widget _formLogIn(BuildContext context){
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _emailInput(),
          SizedBox(height: 5,),
          _passwordInput(),
          SizedBox(height: 5,),
          _logInButton(context)
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
      validator: ValidationBuilder().email("Enter valid email").build(),
    );
  }

  Widget _passwordInput(){
    return TextFormField(
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: "Password"
      ),
      controller: _password,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: ValidationBuilder().minLength(8, "Enter min 8 character").build(),
    );
  }

  Widget _logInButton(BuildContext context){
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state){
        return state.status.isSubmissionInProgress
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: (){
                  _logInButtonFunction(context);
                },
                child: Text("Log In"),
              );
      },
    );
  }

  void _logInButtonFunction(BuildContext context){
    if(_formKey.currentState!.validate()){
      BlocProvider.of<AuthBloc>(context).add(
        LogInRequsted(_email.text, _password.text)
      );
    }
  }

  Widget _goToRegister(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Belum punya akun ?"),
        SizedBox(width: 3,),
        TextButton(
          onPressed: (){
            Navigator.pushNamed(context, Routes.registerScreen);
          },
          child: Text("Register", style: TextStyle(color: Colors.blue),),
        )
      ],
    );
  }
}