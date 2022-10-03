import 'package:bloc_ril_firebase_login/bloc/auth/auth_bloc.dart';
import 'package:bloc_ril_firebase_login/utils/routes.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

class SignInScreen extends StatefulWidget{
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController email;
  late TextEditingController password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
              return _signInView(context);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _signInView(BuildContext context){
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
              _formSignIn(context),
              SizedBox(height: 10,),
              _googleButton(context),
              SizedBox(height: 10,),
              _goToSignUp()
            ],
          ),
        ),
      ),
    );
  }

  Widget _formSignIn(BuildContext context){
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _emailInput(),
          SizedBox(height: 5,),
          _passwordInput(),
          SizedBox(height: 10,),
          _signInButton(context),
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

  Widget _signInButton(BuildContext context){
    return ElevatedButton(
        onPressed: (){
          _authenticateWithEmailAndPassword(context);
        },
        child: Text("Sign In")
    );
  }

  void _authenticateWithEmailAndPassword(BuildContext context){
    if(_formKey.currentState!.validate()){
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(email.text, password.text)
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

  Widget _goToSignUp(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            "Belum punya akun ?"
        ),
        SizedBox(width: 3,),
        TextButton(
          onPressed: (){
            Navigator.pushNamed(context, Routes.signUpScreen);
          },
          child: Text(
            "Sign Up",
            style: TextStyle(color: Colors.blue),
          ),
        )
      ],
    );
  }
}