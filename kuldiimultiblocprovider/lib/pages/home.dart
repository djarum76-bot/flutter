import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuldiimultiblocprovider/bloc/counter.dart';
import 'package:kuldiimultiblocprovider/bloc/theme_bloc.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  context.read<Counter>().decrement();
                },
                icon: Icon(Icons.remove)
            ),
            BlocBuilder<Counter, int>(
              builder: (context, state) {
                return Text(
                  "${state}",
                  style: TextStyle(fontSize: 40),
                );
              },
            ),
            IconButton(
                onPressed: () {
                  BlocProvider.of<Counter>(context).increment();
                },
                icon: Icon(Icons.add)
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ThemeBloc>().changeTheme();
        },
        child: Icon(Icons.color_lens),
      ),
    );
  }
}