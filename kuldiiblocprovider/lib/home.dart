import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuldiiblocprovider/counter.dart';

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
          BlocConsumer<Counter, int>(
              builder: (context, state){
                return Text(
                  "${state}",
                  style: TextStyle(fontSize: 50),
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