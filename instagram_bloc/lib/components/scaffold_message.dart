import 'package:flutter/material.dart';

ScaffoldMessengerState scaffoldMessage(BuildContext context, String message){
  return ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
        SnackBar(content: Text(message))
    );
}