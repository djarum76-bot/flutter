import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiblocprovider/counter_bloc.dart';
import 'package:multiblocprovider/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
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
        child: BlocBuilder<ThemeBloc, bool>(
            builder: (context, state){
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: state ? dark : light,
                home: HomePage(),
              );
            }
        )
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
                    "Angka saat ini : ${state.number}",
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
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            context.read<ThemeBloc>().changeTheme();
          },
          child: Icon(Icons.color_lens),
      ),
    );
  }
}