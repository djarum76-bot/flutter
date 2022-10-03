import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:persist/app/models/screen_model.dart';
import 'package:persist/app/widget/page_color_list.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => IndexedStack(
          children: menuPages,
          index: controller.navMenuIndex(),
        ),
      ),
      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          currentIndex: controller.navMenuIndex(),
          items: controller.navMenuItems,
          onTap: controller.navMenuIndex,
          selectedItemColor: controller.navMenuItemColor,
        ),
      ),
    );
  }
}

class TabNav extends GetView<HomeController> {
  final ScreenModel model;
  TabNav(this.model);
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(model.navKey),
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (_) => PageColorList(model: model)),
    );
  }
}

List<Widget> get menuPages =>
    Get.find<HomeController>().pages ??= screensData.map((e) => TabNav(e)).toList();