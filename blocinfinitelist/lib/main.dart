import 'package:blocinfinitelist/app.dart';
import 'package:blocinfinitelist/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(){
  Bloc.observer = SimpleBlocObserver();
  runApp(const App());
}