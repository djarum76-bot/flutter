import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuldiiblocaccess/bloc/counter.dart';

class Other extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Other"),
      ),
      body: Center(
        child: BlocBuilder<Counter,int>(
          builder: (context,state){
            return Text(
              state.toString(),
              style: TextStyle(fontSize: 30),
            );
          },
        ),
      ),
    );
  }
}