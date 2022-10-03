import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuldiiblocaccess/bloc/counter.dart';
import 'package:kuldiiblocaccess/pages/not_found.dart';
import 'package:kuldiiblocaccess/pages/other.dart';
import 'package:kuldiiblocaccess/pages/home.dart';

class MyRoute{
  Counter counter = Counter();

  Route onRoute(RouteSettings settings){
    switch(settings.name){
      case "/":
        return MaterialPageRoute(
          builder: (context){
            return BlocProvider.value(
                value: counter,
                child: Home(),
            );
          }
        );
      case "/other":
        return MaterialPageRoute(
          builder: (context){
            return BlocProvider.value(
              value: counter,
              child: Other(),
            );
          }
        );
      default:
        return MaterialPageRoute(
          builder: (context){
            return NotFound();
          }
        );
    }
  }
}