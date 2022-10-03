import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movaadmin/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: (){
                  Get.toNamed(Routes.MOVIE);
                },
                child: Text(
                  "Movie"
                )
            ),
            ElevatedButton(
                onPressed: (){
                  Get.toNamed(Routes.SERIES);
                },
                child: Text(
                    "Series"
                )
            )
          ],
        ),
      ),
    );
  }
}
