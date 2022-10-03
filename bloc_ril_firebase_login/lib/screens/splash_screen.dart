import 'package:bloc_ril_firebase_login/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

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
        Navigator.pushNamedAndRemoveUntil(context, Routes.dashboardScreen, (route) => false);
      }else{
        Navigator.pushNamedAndRemoveUntil(context, Routes.signInScreen, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator(),),
    );
  }
}