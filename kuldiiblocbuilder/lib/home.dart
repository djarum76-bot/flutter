import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuldiiblocbuilder/counter_bloc.dart';

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
          BlocBuilder<Counter, int>(
              buildWhen: (prev, curr){
                if(curr % 2 != 0){
                  return true;
                }
                return false;
              },
              bloc: mycounter,
              builder: (context,state){
                return Text(
                  "${state}",
                  style: TextStyle(fontSize: 50),
                );
              }
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