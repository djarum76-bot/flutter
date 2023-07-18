import 'package:flutter/material.dart';

class PoseScreen extends StatelessWidget{
  const PoseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _poseAppBar(),
    );
  }

  AppBar _poseAppBar(){
    return AppBar(
      title: const Text("Pose Detection"),
    );
  }
}