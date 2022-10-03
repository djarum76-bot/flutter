import 'package:belajar_flutter_bloc/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
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
      appBar: AppBar(
        title: Text("Counter App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CounterBloc, CounterState>(
                builder: (context, state){
                  return Text(
                    "Angka Saat Ini : ${state.number}",
                    style: TextStyle(fontSize: 25),
                  );
                }
            ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: (){
                      context.read<CounterBloc>().add(DecrementEvent());
                    },
                    icon: Icon(Icons.remove)
                ),
                IconButton(
                    onPressed: (){
                      context.read<CounterBloc>().add(IncrementEvent());
                    },
                    icon: Icon(Icons.add)
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}