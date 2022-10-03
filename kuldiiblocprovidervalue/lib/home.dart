import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuldiiblocprovidervalue/counter.dart';
import 'package:kuldiiblocprovidervalue/other.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    Counter counter = context.read<Counter>();

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
          BlocConsumer<Counter, int>(
              builder: (context, state){
                return Text(
                  "${state}",
                  style: TextStyle(fontSize: state % 2 == 0 ? 50 : 20),
                );
              },
              listener: (context, state){
                if(state % 5 == 0){
                  final snackBar = SnackBar(
                      content: Text('Yay! A Checkpoint = ${state}')
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: (){
                    // BlocProvider.of<Counter>(context).decrement();
                    counter.decrement();
                  },
                  child: Icon(Icons.remove)
              ),
              ElevatedButton(
                  onPressed: (){
                    // context.read<Counter>().increment();
                    counter.increment();
                  },
                  child: Icon(Icons.add)
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(
                MaterialPageRoute (
                  builder: (BuildContext context) => BlocProvider.value(
                      value: counter,
                      child: Other(),
                  ),
                )
            );

            // Navigator.of(context).push(
            //     MaterialPageRoute (
            //       builder: (BuildContext context) => Other(),
            //     )
            // );
          }
      ),
    );
  }
}