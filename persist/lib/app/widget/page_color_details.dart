import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageColorDetails extends StatelessWidget {
  final String title;
  final int shade;
  final MaterialColor color;

  const PageColorDetails({Key? key, required this.title, required this.shade, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: color,
      ),
      backgroundColor: color[shade],
      body: Center(
        child: Text(
          '$title [$shade]',
          style: Get.textTheme.headline3!.copyWith(
            color: Colors.white,
            backgroundColor: Colors.black45,
          ),
        ),
      ),
    );
  }
}