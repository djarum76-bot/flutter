import 'package:flutter/material.dart';

class ObjectScreen extends StatelessWidget{
  const ObjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _objectAppBar(),
    );
  }

  AppBar _objectAppBar(){
    return AppBar(
      title: const Text("Object Detection"),
    );
  }
}