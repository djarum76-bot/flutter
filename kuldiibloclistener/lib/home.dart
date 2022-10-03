import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuldiibloclistener/counter_bloc.dart';

class HomePage extends StatelessWidget{
  Counter mycounter = Counter(343);

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
          BlocListener<Counter, int>(
              bloc: mycounter,
              listener: (context, state){
                if(state % 5 == 0){
                  final snackBar = SnackBar(
                    content: Text('Yay! A Checkpoint = ${state}'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        // Some code to undo the change.
                      },
                    ),
                  );

                  // Find the ScaffoldMessenger in the widget tree
                  // and use it to show a SnackBar.
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              listenWhen: (prev,curr){
                if(curr % 10 == 0){
                  return true;
                }
                return false;
              },
              child: BlocBuilder<Counter, int>(
                  bloc: mycounter,
                  builder: (context,state){
                    return Text(
                      "${state}",
                      style: TextStyle(fontSize: 50),
                    );
                  }
              ),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: (){
                    mycounter.decrement();
                  },
                  child: Icon(Icons.remove)
              ),
              ElevatedButton(
                  onPressed: (){
                    mycounter.increment();
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