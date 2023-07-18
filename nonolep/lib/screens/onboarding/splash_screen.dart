import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nonolep/models/user_model.dart';
import 'package:nonolep/services/local/local_storage.dart';
import 'package:nonolep/utils/app_routes.dart';
import 'package:nonolep/utils/app_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late LocalStorage _storage;
  late bool _skipIntro;
  late String _token;
  late UserModel _user;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), ()async{
      _storage = LocalStorage.instance;
      _skipIntro = await _storage.skipIntro;
      _token = await _storage.token;

      if(_token.isEmpty){
        if(_skipIntro){
          if(!mounted) return;
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.authenticationScreen, (route) => false);
        }else{
          if(!mounted) return;
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.introductionScreen, (route) => false);
        }
      }else{
        if(JwtDecoder.isExpired(_token)){
          await _storage.deleteData().then((value){
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.authenticationScreen, (route) => false);
          });
        }else{
          _user = await _storage.user;

          if(_user.isFilled!){
            if(!mounted) return;
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashboardScreen, (route) => false);
          }else{
            if(!mounted) return;
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.genderScreen, (route) => false);
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _splashBody(),
    );
  }

  Widget _splashBody(){
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF8769ff),
              AppTheme.primaryColor
            ]
          )
        ),
        child: Column(
          children: [
            _splashIcon(),
            _splashLoading()
          ],
        ),
      ),
    );
  }

  Widget _splashIcon(){
    return Expanded(
      flex: 2,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Icon(LineIcons.dumbbell, size: 18.vmax, color: Colors.white,),
        ),
      ),
    );
  }

  Widget _splashLoading(){
    return Expanded(
      flex: 1,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: LoadingAnimationWidget.beat(
            color: Colors.white,
            size: 6.vmax,
          ),
        ),
      ),
    );
  }
}