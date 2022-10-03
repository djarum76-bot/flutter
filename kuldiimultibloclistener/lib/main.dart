import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuldiimultibloclistener/bloc/counter_bloc.dart';
import 'package:kuldiimultibloclistener/bloc/theme_bloc.dart';
import 'package:kuldiimultibloclistener/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => CounterBloc()
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
              home: MultiBlocListener(
                  listeners: [
                    BlocListener<CounterBloc, int>(
                      listener: (context,state){
                        if(state % 2 == 0){
                          print("GENAP");
                        }else{
                          print("GANJIL");
                        }
                      },
                      listenWhen: (prev, curr){
                        if(curr > 10){
                          return true;
                        }
                        return false;
                      },
                    ),
                    BlocListener<ThemeBloc, bool>(
                      listener: (context,state){
                        if(state){
                          print("Light Mode");
                        }else{
                          print("Dark Mode");
                        }
                      },
                      listenWhen: (prev, curr){
                        if(curr){
                          return true;
                        }
                        return false;
                      },
                    )
                  ],
                  child: Home()
              ),
            );
          },
        )
    );
  }
}
