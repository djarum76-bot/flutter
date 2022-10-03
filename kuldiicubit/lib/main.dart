import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget{

  CounterCubit myCounter = CounterCubit(110);

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
          StreamBuilder(
              initialData: myCounter.state,
              stream: myCounter.stream,
              builder: (context, snapshot){
                return Text(
                  "${snapshot.data}",
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
                    myCounter.decrement();
                  },
                  child: Icon(Icons.remove)
              ),
              ElevatedButton(
                  onPressed: (){
                    myCounter.increment();
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

class  CounterCubit extends Cubit<int>{
  CounterCubit(int initialState) : super(initialState);

  void increment(){
    emit(state + 1);
  }

  void decrement(){
    emit(state - 1);
  }
}