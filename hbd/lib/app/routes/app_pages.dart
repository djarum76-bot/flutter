import 'package:get/get.dart';

import 'package:hbd/app/modules/home/bindings/home_binding.dart';
import 'package:hbd/app/modules/home/views/home_view.dart';
import 'package:hbd/app/modules/main/bindings/main_binding.dart';
import 'package:hbd/app/modules/main/views/main_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => MainView(),
      binding: MainBinding(),
    ),
  ];
}
