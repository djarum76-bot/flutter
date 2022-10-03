import 'package:flutter/material.dart';
import 'package:instagram_bloc/repositories/user_repository.dart';
import 'package:instagram_bloc/utils/any_service.dart';
import 'package:instagram_bloc/utils/constants.dart';
import 'package:instagram_bloc/utils/routes.dart';

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
    Future.delayed(Duration(seconds: 2), () async {
      if(box.read(Constants.token) == null){
        Navigator.pushNamedAndRemoveUntil(context, Routes.loginScreen, (route) => false);
      }else{
        final userModel = await UserRepository().getUser();
        if(userModel.picture!.valid! && userModel.phone!.valid!){
          Navigator.pushNamedAndRemoveUntil(context, Routes.navbarScreen, (route) => false);
        }else{
          Navigator.pushNamedAndRemoveUntil(context, Routes.completeProfileScreen, (route) => false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}