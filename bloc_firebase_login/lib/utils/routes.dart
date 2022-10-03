import 'package:bloc_firebase_login/screens/complete_profile_screen.dart';
import 'package:bloc_firebase_login/screens/login_screen.dart';
import 'package:bloc_firebase_login/screens/profile_screen.dart';
import 'package:bloc_firebase_login/screens/register_screen.dart';
import 'package:bloc_firebase_login/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes{
  static const String splashScreen = "/splash";
  static const String loginScreen = "/login";
  static const String registerScreen = "/register";
  static const String completeProfileScreen = "/complete-profile";
  static const String profileScreen = "/profile";

  static Route<dynamic>? generateRoute(RouteSettings settings){
    switch(settings.name){
      case splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case registerScreen:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case completeProfileScreen:
        return MaterialPageRoute(builder: (_) => CompleteProfileScreen());
      case profileScreen:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      default:
        return MaterialPageRoute(
            builder: (_){
              return Scaffold(
                body: SafeArea(
                  child: Center(
                    child: Text("No route defined for ${settings.name}"),
                  ),
                ),
              );
            }
        );
    }
  }
}