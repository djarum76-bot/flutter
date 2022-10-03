import 'package:bloc_api_login/models/post_model.dart';
import 'package:bloc_api_login/screens/home_screen.dart';
import 'package:bloc_api_login/screens/login_screen.dart';
import 'package:bloc_api_login/screens/navbar_screen.dart';
import 'package:bloc_api_login/screens/post_add_screen.dart';
import 'package:bloc_api_login/screens/post_detail_screen.dart';
import 'package:bloc_api_login/screens/post_edit_screen.dart';
import 'package:bloc_api_login/screens/register_screen.dart';
import 'package:bloc_api_login/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes{
  static const splashScreen = "/splash";
  static const loginScreen = "/login";
  static const registerScreen = "/register";
  static const navbarScreen = "/navbar";
  static const postDetailScreen = "/post/detail";
  static const postAddScreen = "/post/add";
  static const postEditScreen = "/post/edit";

  static Route<dynamic>? generateRoute(RouteSettings settings){
    switch(settings.name){
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case navbarScreen:
        return MaterialPageRoute(builder: (_) => const NavbarScreen());
      case postDetailScreen:
        final args = settings.arguments as ScreenArguments<int>;
        return MaterialPageRoute(builder: (_) => PostDetailScreen(id: args.data));
      case postAddScreen:
        return MaterialPageRoute(builder: (_) => const PostAddScreen());
      case postEditScreen:
        final args = settings.arguments as ScreenArguments<PostModel>;
        return MaterialPageRoute(builder: (_) => PostEditScreen(postModel: args.data,));
      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Text("No route defined for ${settings.name}"),
              ),
            ),
          );
        });
    }
  }
}

class ScreenArguments<T>{
  final T data;

  ScreenArguments(this.data);
}