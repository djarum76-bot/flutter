import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/hal3_controller.dart';

class Hal3View extends GetView<Hal3Controller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hal3View'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Hal3View is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
