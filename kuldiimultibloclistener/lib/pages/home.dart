import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuldiimultibloclistener/bloc/counter_bloc.dart';
import 'package:kuldiimultibloclistener/bloc/theme_bloc.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    CounterBloc counter = context.read<CounterBloc>();
    ThemeBloc theme = context.read<ThemeBloc>();

    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: (){
                  counter.decrement();
                },
                icon: Icon(Icons.remove)
            ),
            BlocBuilder<CounterBloc, int>(
              builder: (context, state){
                return Text(
                  "${state}",
                  style: TextStyle(fontSize: 40),
                );
              },
            ),
            IconButton(
                onPressed: (){
                  counter.increment();
                },
                icon: Icon(Icons.add)
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          theme.changeTheme();
        },
        child: Icon(Icons.color_lens),
      ),
    );
  }
}