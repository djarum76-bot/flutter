import 'package:bloc_ril_firebase_login/screens/dashboard_screen.dart';
import 'package:bloc_ril_firebase_login/screens/sign_in_screen.dart';
import 'package:bloc_ril_firebase_login/screens/sign_up_screen.dart';
import 'package:bloc_ril_firebase_login/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes{
  static const signInScreen = "/sign-in";
  static const signUpScreen = "/sign-up";
  static const dashboardScreen = "/dashboard";
  static const splashScreen = "/splash";

  static Route<dynamic>? generateRoute(RouteSettings settings){
    switch(settings.name){
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case signInScreen:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case dashboardScreen:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            body: Center(
              child: Text("No route defined for ${settings.name}"),
            ),
          );
        });
    }
  }
}