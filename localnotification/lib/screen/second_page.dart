import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget{
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _secondAppBar(),
    );
  }

  AppBar _secondAppBar(){
    return AppBar(
      title: const Text("Second"),
    );
  }
}