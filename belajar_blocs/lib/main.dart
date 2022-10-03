import 'package:belajar_blocs/blocs/counter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  CounterBloc bloc = CounterBloc();

  @override
  void dispose() {
    // TODO: implement dispose
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter BLoC"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
                stream: bloc.output,
                initialData: bloc.counter,
                builder: (context, snapshot){
                  return Text(
                    "Angka Saat Ini : ${snapshot.data}",
                    style: TextStyle(fontSize: 25),
                  );
                }
            ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: (){
                      bloc.inputan.add('kurang');
                    },
                    icon: Icon(Icons.remove)
                ),
                IconButton(
                    onPressed: (){
                      bloc.inputan.add('add');
                    },
                    icon: Icon(Icons.add)
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}