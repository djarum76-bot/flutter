import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget{
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _firstAppBar(),
    );
  }

  AppBar _firstAppBar(){
    return AppBar(
      title: const Text("First"),
    );
  }
}