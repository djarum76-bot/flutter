import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuldiiextensionmethod/bloc/counter_bloc.dart';
import 'package:kuldiiextensionmethod/bloc/user_bloc.dart';

class Home extends StatelessWidget{
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //EXTENSION METHOD
    // CounterBloc counterBloc = context.read<CounterBloc>(); //hanya dibaca 1x (pertama kali)
    // CounterBloc counterBloc = context.watch<CounterBloc>(); // membaca berkali kali (ketika state pada bloc berubah)

    // membaca berkali kali (ketika state pada bloc berubah)

    return Scaffold(
      appBar: AppBar(
        title: Text("HOME"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: (){
                      // context.read<CounterBloc>().decrement();
                      context.read<UserBloc>().changeAge(context.read<UserBloc>().state["age"]-1);
                    },
                    icon: Icon(Icons.remove)
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Builder(
                      builder: (context){
                        String name = context.select<UserBloc, String>((value) => value.state["name"]);
                        return Text(
                          "$name",
                          style: TextStyle(fontSize: 20),
                        );
                      },
                    ),
                    Builder(
                      builder: (context){
                        int age = context.select<UserBloc, int>((value) => value.state["age"]);
                        return Text(
                          "$age",
                          style: TextStyle(fontSize: 20),
                        );
                      },
                    )
                  ],
                ),
                // Builder(
                //     builder: (context){
                //       CounterBloc counterBloc = context.watch<CounterBloc>();
                //       return Text(
                //         "${counterBloc.state}",
                //         style: TextStyle(fontSize: 40),
                //       );
                //     }
                // ),
                IconButton(
                    onPressed: (){
                      // context.read<CounterBloc>().increment();
                      context.read<UserBloc>().changeAge(context.read<UserBloc>().state["age"] + 1);
                    },
                    icon: Icon(Icons.add)
                )
              ],
            ),
            SizedBox(height: 20,),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder()
              ),
              onChanged: (val){
                context.read<UserBloc>().changeName(val);
              },
            )
          ],
        ),
      ),
    );
  }
}