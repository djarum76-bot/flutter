import 'package:flutter/material.dart';

class FaceScreen extends StatelessWidget{
  const FaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _faceAppBar(),
    );
  }

  AppBar _faceAppBar(){
    return AppBar(
      title: const Text("Face Detection"),
    );
  }
}