import 'package:get/get.dart';

import '../controllers/hal2_controller.dart';

class Hal2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Hal2Controller>(
      () => Hal2Controller(),
    );
  }
}
