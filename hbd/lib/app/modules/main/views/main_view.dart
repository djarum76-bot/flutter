import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hbd/app/controllers/utama_controller.dart';
import 'package:lottie/lottie.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  final utamaC = Get.find<UtamaController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
                "${utamaC.nama}",
                style: TextStyle(fontSize: 35),
            ),
            Lottie.asset("asset/hbd.json"),
            Text(
              "Yang Ke ${utamaC.umur}",
              style: TextStyle(fontSize: 35),
            ),
          ],
        )
      ),
    );
  }
}
