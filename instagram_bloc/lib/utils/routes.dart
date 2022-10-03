import 'package:flutter/material.dart';
import 'package:instagram_bloc/screens/comment_screen.dart';
import 'package:instagram_bloc/screens/complete_profile_screen.dart';
import 'package:instagram_bloc/screens/login_screen.dart';
import 'package:instagram_bloc/screens/navbar_screen.dart';
import 'package:instagram_bloc/screens/post_add_screen.dart';
import 'package:instagram_bloc/screens/register_screen.dart';
import 'package:instagram_bloc/screens/splash_screen.dart';

class Routes{
  static const splashScreen = "/splash";
  static const loginScreen = "/login";
  static const registerScreen = "/register";
  static const completeProfileScreen = "/complete-profile";
  static const navbarScreen = "/navbar";
  static const postAddScreen = "/post/add";
  static const commentScreen = "/comment";

  static Route<dynamic>? generateRoutes(RouteSettings settings){
    switch(settings.name){
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case completeProfileScreen:
        return MaterialPageRoute(builder: (_) => const CompleteProfileScreen());
      case navbarScreen:
        return MaterialPageRoute(builder: (_) => const NavbarScreen());
      case postAddScreen:
        return MaterialPageRoute(builder: (_) => const PostAddScreen());
      case commentScreen:
        final args = settings.arguments as ScreenArgument<int>;
        return MaterialPageRoute(builder: (_) => CommentScreen(id: args.data));
      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            body: Center(child: Text("No route defined for ${settings.name}"),),
          );
        });
    }
  }
}

class ScreenArgument<T>{
  final T data;

  ScreenArgument(this.data);
}