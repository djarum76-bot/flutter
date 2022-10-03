import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuldiidependencyinjection/counter.dart';

class IniBloc extends StatelessWidget {
  const IniBloc({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Counter, int>(
        builder: (context, state){
          return Text(
            "${state}",
            style: TextStyle(fontSize: state % 2 == 0 ? 50 : 20),
          );
        },
        listener: (context, state){
          if(state % 5 == 0){
            final snackBar = SnackBar(
                content: Text('Yay! A Checkpoint = ${state}')
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
    );
  }
}