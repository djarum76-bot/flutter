import 'package:crudgolang/app/controllers/models_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  final modelC = Get.put(ModelsController(),permanent: true);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      initialRoute: Routes.HOME,
      getPages: AppPages.routes,
    );
  }
}