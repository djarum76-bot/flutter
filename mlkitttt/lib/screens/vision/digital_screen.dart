import 'package:flutter/material.dart';

class DigitalScreen extends StatelessWidget{
  const DigitalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _digitalAppBar(),
    );
  }

  AppBar _digitalAppBar(){
    return AppBar(
      title: const Text("Digital Ink"),
    );
  }
}