import 'package:camera/camera.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final isWorking = false.obs;
  final result = "".obs;

  Rx<CameraController> cameraController = CameraController(description, resolutionPreset).obs;
}
