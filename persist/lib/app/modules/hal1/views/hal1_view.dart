import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/hal1_controller.dart';

class Hal1View extends GetView<Hal1Controller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hal1View'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Hal1View is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
