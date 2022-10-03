import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuldiimultiblocprovider/bloc/counter.dart';
import 'package:kuldiimultiblocprovider/bloc/theme_bloc.dart';
import 'package:kuldiimultiblocprovider/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => Counter(),
          ),
          BlocProvider(
            create: (context) => ThemeBloc(),
          )
        ],
        child: BlocBuilder<ThemeBloc, bool>(
          builder: (context, state){
            return MaterialApp(
              title: 'Flutter Demo',
              theme: state ? ThemeData.light() : ThemeData.dark(),
              home: Home(),
            );
          },
        )
    );
  }
}