import 'package:bloc_ril_firebase_login/bloc/auth/auth_bloc.dart';
import 'package:bloc_ril_firebase_login/repositories/auth_repository.dart';
import 'package:bloc_ril_firebase_login/repositories/user_repository.dart';
import 'package:bloc_ril_firebase_login/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => UserRepository(),
        )
      ],
      child: BlocProvider(
        create: (context) => AuthBloc(
            authRepository: RepositoryProvider.of<AuthRepository>(context),
            userRepository: RepositoryProvider.of<UserRepository>(context)
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.blue
          ),
          onGenerateRoute: Routes.generateRoute,
          initialRoute: Routes.splashScreen,
        ),
      ),
    );
  }
}