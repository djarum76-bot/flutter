import 'package:get/get.dart';

import '../controllers/series_controller.dart';

class SeriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SeriesController>(
      () => SeriesController(),
    );
  }
}
