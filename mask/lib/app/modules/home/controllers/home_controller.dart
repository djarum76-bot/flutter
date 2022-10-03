import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class HomeController extends GetxController {
  var selectedImagePath = "".obs;
  final predictions = [].obs;
  final loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadModel();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  getImage(ImageSource imageSource)async{
    final pickedFile = await ImagePicker().pickImage(source: imageSource);

    if(pickedFile != null){
      selectedImagePath.value = pickedFile.path;
      detectImage(File(selectedImagePath.value));
    }else{
      Get.snackbar("Error", "No image selected");
    }
  }

  loadModel()async{
    await Tflite.loadModel(model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  detectImage(File image)async{
    var prediction = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.6,
        imageMean: 127.5,
        imageStd: 127.5
    );

    loading.value = true;
    predictions.value = prediction!;
  }
}
