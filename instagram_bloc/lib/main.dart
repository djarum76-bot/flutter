import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:instagram_bloc/bloc/auth/auth_bloc.dart';
import 'package:instagram_bloc/bloc/post/post_bloc.dart';
import 'package:instagram_bloc/repositories/auth_repository.dart';
import 'package:instagram_bloc/repositories/comment_repository.dart';
import 'package:instagram_bloc/repositories/post_repository.dart';
import 'package:instagram_bloc/repositories/user_repository.dart';
import 'package:instagram_bloc/utils/routes.dart';

void main()async{
  await GetStorage.init();
  runApp(MyApp());
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
        ),
        RepositoryProvider(
          create: (context) => PostRepository(),
        ),
        RepositoryProvider(
          create: (context) => CommentRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
                authRepository: RepositoryProvider.of<AuthRepository>(context),
                userRepository: RepositoryProvider.of<UserRepository>(context)
            ),
          ),
          BlocProvider(
            create: (context) => PostBloc(postRepository: RepositoryProvider.of<PostRepository>(context)),
          ),
          BlocProvider(
            create: (context) => PostBloc(postRepository: RepositoryProvider.of<PostRepository>(context))..add(AllPostFetched()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.teal
          ),
          onGenerateRoute: Routes.generateRoutes,
          initialRoute: Routes.splashScreen,
        ),
      )
    );
  }
}