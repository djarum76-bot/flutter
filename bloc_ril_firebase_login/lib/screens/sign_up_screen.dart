import 'package:bloc_ril_firebase_login/bloc/auth/auth_bloc.dart';
import 'package:bloc_ril_firebase_login/utils/routes.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

class SignUpScreen extends StatefulWidget{
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    username.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state){
            if(state is AuthError){
              ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text(state.error))
                  );
            }

            if(state is Authenticated){
              Navigator.pushNamedAndRemoveUntil(context, Routes.dashboardScreen, (route) => false);
            }
          },
          builder: (context, state){
            if(state is Loading){
              return Center(child: CircularProgressIndicator(),);
            }
            if(state is UnAuthenticated){
              return _signUpView(context);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _signUpView(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.all(10),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _formSignUp(context),
              SizedBox(height: 10,),
              _googleButton(context),
              SizedBox(height: 10,),
              _goToSignIn()
            ],
          ),
        ),
      ),
    );
  }

  Widget _formSignUp(BuildContext context){
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _usernameInput(),
          SizedBox(height: 5,),
          _emailInput(),
          SizedBox(height: 5,),
          _passwordInput(),
          SizedBox(height: 10,),
          _signUpButton(context),
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
      controller: username,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value){
        if(value!.isEmpty){
          return "Isi dong bang";
        }else{
          return null;
        }
      },
    );
  }

  Widget _emailInput(){
    return TextFormField(
      decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: "Email"
      ),
      controller: email,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value){
        if(value != null && !EmailValidator.validate(value)){
          return "Enter valid email";
        }else{
          return null;
        }
      },
    );
  }

  Widget _passwordInput(){
    return TextFormField(
      decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: "Password"
      ),
      obscureText: true,
      controller: password,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value){
        if(value!.isEmpty || value.length < 8){
          return "Enter min 8 character";
        }else{
          return null;
        }
      },
    );
  }

  Widget _signUpButton(BuildContext context){
    return ElevatedButton(
        onPressed: (){
          _authenticateWithEmailAndPassword(context);
        },
        child: Text("Sign Up")
    );
  }

  void _authenticateWithEmailAndPassword(BuildContext context){
    if(_formKey.currentState!.validate()){
      BlocProvider.of<AuthBloc>(context).add(
        SignUpRequested(username.text, email.text, password.text)
      );
    }
  }

  Widget _googleButton(BuildContext context){
    return IconButton(
      onPressed: (){
        _authenticateWithGoogle(context);
      },
      icon: Icon(LineIcons.googleLogo),
    );
  }

  void _authenticateWithGoogle(BuildContext context){
    BlocProvider.of<AuthBloc>(context).add(
      GoogleSignInRequested()
    );
  }

  Widget _goToSignIn(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            "Sudah punya akun ?"
        ),
        SizedBox(width: 3,),
        TextButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text(
            "Sign In",
            style: TextStyle(color: Colors.blue),
          ),
        )
      ],
    );
  }
}