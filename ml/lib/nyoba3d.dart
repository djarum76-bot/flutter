import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class Nyoba3D extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Cube(
        onSceneCreated: (Scene scene) {
          scene.world.add(Object(fileName: 'asset/hair.obj'));
        },
      ),
    );
  }
}