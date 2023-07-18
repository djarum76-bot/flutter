import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nonolep/bloc/user/user_bloc.dart';
import 'package:nonolep/repositories/user_repository.dart';
import 'package:nonolep/services/local/adapter/user_adapter.dart';
import 'package:nonolep/utils/app_routes.dart';
import 'package:nonolep/utils/app_theme.dart';
import 'package:nonolep/utils/list_view_behavior.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark
        )
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => UserRepository())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserBloc(userRepository: RepositoryProvider.of<UserRepository>(context)),
          )
        ],
        child: ResponsiveSizer(
          builder: (context, orientation, screenType){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.theme(),
              builder: (context, child){
                return ScrollConfiguration(
                  behavior: ListViewBehavior(),
                  child: child!,
                );
              },
              onGenerateRoute: AppRoutes.onGenerateRoutes,
              initialRoute: AppRoutes.splashScreen,
            );
          },
        ),
      ),
    );
  }
}
