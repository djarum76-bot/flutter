import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hbd/app/routes/app_pages.dart';

class UtamaController extends GetxController {
  late TextEditingController namaC;
  late TextEditingController umurC;
  late String nama;
  late String umur;

  @override
  void onInit() {
    namaC = TextEditingController();
    umurC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    namaC.dispose();
    umurC.dispose();
    super.onClose();
  }

  void next(String namaF, String umurF){
    if(namaF != '' && umurF != ''){
      nama = namaF;
      umur = umurF;
      Get.toNamed(Routes.MAIN);
    }else{
      Get.defaultDialog(
        title: "Error",
        middleText: "Masukkan nama dan umur"
      );
    }
  }
}
