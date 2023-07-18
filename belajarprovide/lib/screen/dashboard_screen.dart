import 'package:belajarprovide/provider/counter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Consumer<Counter>(
            builder: (context, count, child){
              return Text(
                count.count.toString()
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<Counter>(context, listen: false).increment(),
      ),
    );
  }
}