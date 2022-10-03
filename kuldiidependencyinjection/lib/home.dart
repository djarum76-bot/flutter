import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuldiidependencyinjection/counter.dart';
import 'package:kuldiidependencyinjection/ini_bloc.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Cubit"
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Container(
              child: IniBloc(),
            ),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: (){
                    BlocProvider.of<Counter>(context).decrement();
                  },
                  child: Icon(Icons.remove)
              ),
              ElevatedButton(
                  onPressed: (){
                    context.read<Counter>().increment();
                  },
                  child: Icon(Icons.add)
              )
            ],
          )
        ],
      ),
    );
  }
}