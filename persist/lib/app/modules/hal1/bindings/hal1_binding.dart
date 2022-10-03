import 'package:get/get.dart';

import '../controllers/hal1_controller.dart';

class Hal1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Hal1Controller>(
      () => Hal1Controller(),
    );
  }
}
