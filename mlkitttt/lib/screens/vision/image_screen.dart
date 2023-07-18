import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget{
  const ImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _imageAppBar(),
    );
  }

  AppBar _imageAppBar(){
    return AppBar(
      title: const Text("Image Labeling"),
    );
  }
}