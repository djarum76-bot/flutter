import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuldiiblocaccess/bloc/counter.dart';
import 'package:kuldiiblocaccess/pages/home.dart';
import 'package:kuldiiblocaccess/pages/other.dart';
import 'package:kuldiiblocaccess/routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  MyRoute route = MyRoute();

  // @override
  // Widget build(BuildContext context) {
  //   return BlocProvider(
  //     create: (context) => Counter(),
  //     child: MaterialApp(
  //       title: 'Flutter Demo',
  //       theme: ThemeData(
  //         primarySwatch: Colors.blue,
  //       ),
  //       home: Home(),
  //     ),
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Flutter Demo',
  //     theme: ThemeData(
  //       primarySwatch: Colors.blue,
  //     ),
  //
  //     initialRoute: "/",
  //     routes: {
  //       "/" : (context) => BlocProvider.value(
  //         value: counter,
  //         child: Home(),
  //       ),
  //       "/other" : (context) => BlocProvider.value(
  //         value: counter,
  //         child: Other(),
  //       )
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: route.onRoute,
    );
  }
}