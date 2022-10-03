import 'package:get/get.dart';

import '../controllers/hal3_controller.dart';

class Hal3Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Hal3Controller>(
      () => Hal3Controller(),
    );
  }
}
