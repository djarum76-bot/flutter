import 'package:bloc_firebase_login/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final _currUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), (){
      if(_currUser != null){
        Navigator.pushNamedAndRemoveUntil(context, Routes.profileScreen, (route) => false);
      }else{
        Navigator.pushNamedAndRemoveUntil(context, Routes.loginScreen, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Loading dulu pren",
                style: TextStyle(fontSize: 22),
              ),
              CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}