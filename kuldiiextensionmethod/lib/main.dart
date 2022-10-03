import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuldiiextensionmethod/bloc/counter_bloc.dart';
import 'package:kuldiiextensionmethod/bloc/user_bloc.dart';
import 'package:kuldiiextensionmethod/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CounterBloc(),
            ),
            BlocProvider(
              create: (context) => UserBloc(),
            )
          ],
          child: Home()
      ),
    );
  }
}