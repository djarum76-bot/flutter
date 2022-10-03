import 'package:bloc_ril_api_login/utils/any_service.dart';
import 'package:bloc_ril_api_login/utils/constants.dart';
import 'package:bloc_ril_api_login/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), (){
      if(box.read(Constants.token) != null){
        if(JwtDecoder.isExpired(box.read(Constants.token))){
          Navigator.pushNamedAndRemoveUntil(context, Routes.logInScreen, (route) => false);
        }else{
          Navigator.pushNamedAndRemoveUntil(context, Routes.navbarScreen, (route) => false);
        }
      }else{
        Navigator.pushNamedAndRemoveUntil(context, Routes.logInScreen, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}