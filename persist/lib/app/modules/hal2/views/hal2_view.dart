import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/hal2_controller.dart';

class Hal2View extends GetView<Hal2Controller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hal2View'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Hal2View is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
