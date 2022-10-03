import 'package:bloc_ril_api_login/models/post_model.dart';
import 'package:bloc_ril_api_login/screens/log_in_screen.dart';
import 'package:bloc_ril_api_login/screens/navbar_screen.dart';
import 'package:bloc_ril_api_login/screens/post_add_screen.dart';
import 'package:bloc_ril_api_login/screens/post_edit_screen.dart';
import 'package:bloc_ril_api_login/screens/post_screen.dart';
import 'package:bloc_ril_api_login/screens/register_screen.dart';
import 'package:bloc_ril_api_login/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes{
  static const splashScreen = "/splash";
  static const logInScreen = "/log-in";
  static const registerScreen = "/register";
  static const navbarScreen = "/navbar";
  static const postScreen = "/post";
  static const postAddScreen = "/post/add";
  static const postEditScreen = "/post/edit";

  static Route<dynamic>? generateRoute(RouteSettings settings){
    switch(settings.name){
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case logInScreen:
        return MaterialPageRoute(builder: (_) => const LogInScreen());
      case registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case navbarScreen:
        return MaterialPageRoute(builder: (_) => const NavbarScreen());
      case postScreen:
        final args = settings.arguments as ScreenArguments<int>;
        return MaterialPageRoute(builder: (_) => PostScreen(id: args.data));
      case postAddScreen:
        return MaterialPageRoute(builder: (_) => const PostAddScreen());
      case postEditScreen:
        final args = settings.arguments as ScreenArguments<PostModel>;
        return MaterialPageRoute(builder: (_) => PostEditScreen(postModel: args.data));
      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            body: Center(child: Text("No route defined for ${settings.name}"),),
          );
        });
    }
  }
}

class ScreenArguments<T>{
  final T data;

  ScreenArguments(this.data);
}