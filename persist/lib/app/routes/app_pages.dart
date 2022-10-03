import 'package:get/get.dart';

import '../modules/hal1/bindings/hal1_binding.dart';
import '../modules/hal1/views/hal1_view.dart';
import '../modules/hal2/bindings/hal2_binding.dart';
import '../modules/hal2/views/hal2_view.dart';
import '../modules/hal3/bindings/hal3_binding.dart';
import '../modules/hal3/views/hal3_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

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
      name: _Paths.HAL1,
      page: () => Hal1View(),
      binding: Hal1Binding(),
    ),
    GetPage(
      name: _Paths.HAL2,
      page: () => Hal2View(),
      binding: Hal2Binding(),
    ),
    GetPage(
      name: _Paths.HAL3,
      page: () => Hal3View(),
      binding: Hal3Binding(),
    ),
  ];
}
