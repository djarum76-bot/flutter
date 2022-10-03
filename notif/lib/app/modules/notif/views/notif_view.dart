import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notif_controller.dart';

class NotifView extends GetView<NotifController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NotifView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'NotifView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
