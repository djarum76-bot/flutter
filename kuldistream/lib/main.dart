import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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

  Stream<int>increment() async* {
    int i = 0;
    while(true){
      yield i;
      await Future.delayed(Duration(seconds: 1));
      i++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Stream App"
        ),
      ),
      body: StreamBuilder(
          stream: increment(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.active){
              return Center(
                child: Text(
                  "${snapshot.data}",
                  style: TextStyle(fontSize: 50),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }
      ),
    );
  }
}