import 'package:bloc_api_login/utils/constants.dart';
import 'package:bloc_api_login/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    String? token = box.read(Constants.token);
    Future.delayed(const Duration(seconds: 2), (){
      if(token != null){
        if(JwtDecoder.isExpired(token)){
          box.remove(Constants.token);
          box.erase();
          Navigator.pushNamedAndRemoveUntil(context, Routes.loginScreen, (route) => false);
        }else{
          Navigator.pushNamedAndRemoveUntil(context, Routes.navbarScreen, (route) => false);
        }
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
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