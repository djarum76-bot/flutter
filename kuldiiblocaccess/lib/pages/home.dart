import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuldiiblocaccess/bloc/counter.dart';
import 'package:kuldiiblocaccess/pages/other.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // Counter counter = BlocProvider.of<Counter>(context);
    Counter counter = context.read<Counter>();

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
            BlocConsumer<Counter, int>(
                builder: (context, state){
                  return Text(
                    state.toString(),
                    style: TextStyle(fontSize: 30),
                  );
                },
                listener: (context, state){
                  if(state % 2 == 0){
                    print(state);
                  }
                }
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
            //global access
            // Navigator.of(context).push(
            //     MaterialPageRoute(
            //         builder: (context){
            //           return Other();
            //         }
            //     )
            // );

            //anonymous route access
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //       builder: (context){
            //         return BlocProvider.value(
            //           value: counter,
            //           child: Other(),
            //         );
            //       }
            //   )
            // );

            //name route access
            Navigator.of(context).pushNamed("/other");
          }
      ),
    );
  }
}