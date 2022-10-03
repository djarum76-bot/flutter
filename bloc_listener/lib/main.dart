import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData dark = ThemeData.dark();
  final ThemeData light = ThemeData.light();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CounterBloc>(
              create: (context) => CounterBloc()
          ),
          BlocProvider<ThemeBloc>(
              create: (context) => ThemeBloc()
          )
        ],
        child: MultiBlocListener(
            listeners: [
              BlocListener<CounterBloc, int>(
                  listener: (context, state){
                    if(state > 5){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("Lebih dari 5"),
                        )
                      );
                    }
                  }
              )
            ],
            child: MaterialApp(
              home: HomePage(),
            )
        )
    );
  }
}

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: BlocBuilder<CounterBloc, int>(
            builder: (context, state){
              return Text(
                "$state",
                style: TextStyle(fontSize: 25),
              );
            }
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            context.read<CounterBloc>().increment();
          }
      ),
    );
  }
}

class CounterBloc extends Cubit<int>{
  CounterBloc() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}

class ThemeBloc extends Cubit<bool>{
  ThemeBloc() : super(false);

  void changeTheme() => emit(!state);
}