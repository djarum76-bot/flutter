import 'package:crudgolang/app/controllers/sevice_controller.dart';
import 'package:crudgolang/app/modules/home/controllers/home_controller.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddController extends GetxController {
  late TextEditingController kodeBarang;
  late TextEditingController namaBarang;

  final homeC = Get.find<HomeController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    kodeBarang = TextEditingController();
    namaBarang = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    kodeBarang.dispose();
    namaBarang.dispose();
  }

  addBarang()async{
    Dio.FormData formData = Dio.FormData.fromMap({
      'kodebarang':kodeBarang.text,
      'namabarang':namaBarang.text
    });

    final response = await dio.post('/barang',
        data: formData,
        options: Dio.Options(
            headers: {
              "Accept": "application/json",
            }
        )
    );

    final data = response.data;

    if(response.statusCode == 200){
      await homeC.getAllBarang();
      Get.back();
    }
  }
}
