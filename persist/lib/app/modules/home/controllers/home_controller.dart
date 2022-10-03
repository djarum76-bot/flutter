import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persist/app/models/screen_model.dart';
import 'package:persist/app/widget/page_color_details.dart';

class HomeController extends GetxController {
  final navMenuIndex = 0.obs;

  ScreenModel get currentScreenModel => screensData[navMenuIndex()];
  Color get navMenuItemColor => currentScreenModel.colors;

  // store the pages stack.
  List<Widget>? pages;

  // get navigators.


  // widget stuffs.
  List<BottomNavigationBarItem> get navMenuItems => screensData
      .map((e) =>
      BottomNavigationBarItem(icon: Icon(Icons.widgets), label: e.name))
      .toList();

  void openDetails(int shade) {
    final model = currentScreenModel;
    Get.to(
      PageColorDetails(
        title: model.name,
        color: model.colors,
        shade: shade,
      ),
      transition: Transition.fade,
      id: model.navKey,
    );
  }
}
