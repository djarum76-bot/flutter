import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
          create: (context) => CounterBloc(),
          child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: BlocConsumer<CounterBloc, int>(
            buildWhen: (prev, curr){
              if(curr > 3){
                return true;
              }
              return false;
            },
            listenWhen: (prev, curr){
              if(curr > 10){
                return true;
              }
              return false;
            },
            builder: (context, state){
              return Text(
                "$state",
                style:  TextStyle(fontSize: 25),
              );
            },
            listener: (context, state){
              if(state > 5){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text("Lebih dari 5")
                  )
                );
              }
            }
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            context.read<CounterBloc>().increment();
          },
          child: Icon(Icons.add),
      ),
    );
  }
}

class CounterBloc extends Cubit<int>{
  CounterBloc() : super(0);

  void increment() => emit(state + 1);
}