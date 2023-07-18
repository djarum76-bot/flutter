import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nonolep/models/user_model.dart';
import 'package:nonolep/models/workout_detail_model.dart';
import 'package:nonolep/models/workout_model.dart';
import 'package:nonolep/screens/account/age_screen.dart';
import 'package:nonolep/screens/account/edit_profile_screen.dart';
import 'package:nonolep/screens/account/gender_screen.dart';
import 'package:nonolep/screens/account/goal_screen.dart';
import 'package:nonolep/screens/account/height_screen.dart';
import 'package:nonolep/screens/account/level_screen.dart';
import 'package:nonolep/screens/account/fill_profile_screen.dart';
import 'package:nonolep/screens/account/weight_screen.dart';
import 'package:nonolep/screens/auhentication/authentication_screen.dart';
import 'package:nonolep/screens/auhentication/login_screen.dart';
import 'package:nonolep/screens/auhentication/register_screen.dart';
import 'package:nonolep/screens/dashboard/dashboard_screen.dart';
import 'package:nonolep/screens/home/bookmark_screen.dart';
import 'package:nonolep/screens/home/notification_screen.dart';
import 'package:nonolep/screens/home/workout_level_screen.dart';
import 'package:nonolep/screens/onboarding/introduction_screen.dart';
import 'package:nonolep/screens/onboarding/onboarding_screen.dart';
import 'package:nonolep/screens/onboarding/splash_screen.dart';
import 'package:nonolep/screens/workout/all_workout_activity_screen.dart';
import 'package:nonolep/screens/workout/congratulation_screen.dart';
import 'package:nonolep/screens/workout/workout_activity_screen.dart';
import 'package:nonolep/screens/workout/workout_detail_screen.dart';
import 'package:nonolep/utils/screen_argument.dart';

class AppRoutes{
  static const splashScreen = '/splash';
  static const introductionScreen = '/introduction';
  static const onboardingScreen = '/onboarding';
  static const authenticationScreen = '/authentication';
  static const loginScreen = '/login';
  static const registerScreen = '/register';
  static const genderScreen = '/gender';
  static const ageScreen = '/age';
  static const weightScreen = '/weight';
  static const heightScreen = '/height';
  static const goalScreen = '/goal';
  static const levelScreen = '/level';
  static const fillProfileScreen = '/fill-profile';
  static const dashboardScreen = '/dashboard';
  static const workoutLevelScreen = '/workout-level';
  static const notificationScreen = '/notification';
  static const bookmarkScreen = '/bookmark';
  static const workoutDetailScreen = '/workout-detail';
  static const allWorkoutActivityScreen = '/all-workout-activity';
  static const workoutActivityScreen = '/workout-activity';
  static const congratulationScreen = '/congratulation';
  static const editProfileScreen = '/edit-profile';

  static Route<dynamic>? onGenerateRoutes(RouteSettings settings){
    switch(settings.name){
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case introductionScreen:
        return MaterialPageRoute(builder: (_) => const IntroductionScreen());
      case onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case authenticationScreen:
        return MaterialPageRoute(builder: (_) => const AuthenticationScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case genderScreen:
        return MaterialPageRoute(builder: (_) => const GenderScreen());
      case ageScreen:
        return MaterialPageRoute(builder: (_) => const AgeScreen());
      case weightScreen:
        return MaterialPageRoute(builder: (_) => const WeightScreen());
      case heightScreen:
        return MaterialPageRoute(builder: (_) => const HeightScreen());
      case goalScreen:
        return MaterialPageRoute(builder: (_) => const GoalScreen());
      case levelScreen:
        return MaterialPageRoute(builder: (_) => const LevelScreen());
      case fillProfileScreen:
        final args = settings.arguments as ScreenArgument<String>;
        return MaterialPageRoute(builder: (_) => FillProfileScreen(email: args.data));
      case dashboardScreen:
        return MaterialPageRoute(builder: (_) => DashboardScreen());
      case workoutLevelScreen:
        return MaterialPageRoute(builder: (_) => const WorkoutLevelScreen());
      case notificationScreen:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
      case bookmarkScreen:
        return MaterialPageRoute(builder: (_) => const BookmarkScreen());
      case workoutDetailScreen:
        final args = settings.arguments as ScreenArgument<WorkoutModel>;
        return MaterialPageRoute(builder: (_) => WorkoutDetailScreen(workoutModel: args.data));
      case allWorkoutActivityScreen:
        final args = settings.arguments as ScreenArgument<List<WorkoutActivityModel>>;
        return MaterialPageRoute(builder: (_) => AllWorkoutActivityScreen(workoutActivityModel: args.data));
      case workoutActivityScreen:
        final args = settings.arguments as ScreenArgument<List<WorkoutActivityModel>>;
        return MaterialPageRoute(builder: (_) => WorkoutActivityScreen(workoutActivityModel: args.data));
      case congratulationScreen:
        final args = settings.arguments as ScreenArgument<List<WorkoutActivityModel>>;
        return MaterialPageRoute(builder: (_) => CongratulationScreen(workoutActivityModel: args.data));
      case editProfileScreen:
        final args = settings.arguments as ScreenArgument<UserModel>;
        return MaterialPageRoute(builder: (_) => EditProfileScreen(user: args.data));
      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            body: Center(
              child: Text(
                "No route defined for ${settings.name}",
                style: GoogleFonts.urbanist(color: Colors.white),
              ),
            ),
          );
        });
    }
  }
}