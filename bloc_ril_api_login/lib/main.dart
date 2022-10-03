import 'package:bloc_ril_api_login/bloc/auth/auth_bloc.dart';
import 'package:bloc_ril_api_login/bloc/post/post_bloc.dart';
import 'package:bloc_ril_api_login/repositories/auth_repository.dart';
import 'package:bloc_ril_api_login/repositories/post_repository.dart';
import 'package:bloc_ril_api_login/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

void main()async{
  await GetStorage.init();
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
          create: (context) => PostRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(authRepository: RepositoryProvider.of<AuthRepository>(context)),
          ),
          BlocProvider(
            create: (context) => PostBloc(postRepository: RepositoryProvider.of<PostRepository>(context)),
          )
        ],
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