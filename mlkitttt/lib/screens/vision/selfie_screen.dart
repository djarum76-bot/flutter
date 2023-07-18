import 'package:flutter/material.dart';

class SelfieScreen extends StatelessWidget{
  const SelfieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selfieAppBar(),
    );
  }

  AppBar _selfieAppBar(){
    return AppBar(
      title: const Text("Selfie Recognition"),
    );
  }
}