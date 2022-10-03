import 'package:crudgolang/app/controllers/models_controller.dart';
import 'package:crudgolang/app/controllers/sevice_controller.dart';
import 'package:crudgolang/app/models/barang_model.dart';
import 'package:crudgolang/app/modules/detail/controllers/detail_controller.dart';
import 'package:crudgolang/app/modules/home/controllers/home_controller.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateController extends GetxController {
  late TextEditingController kodeBarang;
  late TextEditingController namaBarang;

  final homeC = Get.find<HomeController>();
  final detailC = Get.find<DetailController>();
  final modelC = Get.find<ModelsController>();

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

  getBarang()async{
    final response = await dio.get('/barang/${Get.arguments}',
        options: Dio.Options(
            headers: {
              "Accept": "application/json"
            }
        )
    );

    final data = response.data;

    if(response.statusCode == 200){
      modelC.barang(BarangModel.fromJson(data));
      modelC.barang.refresh();

      kodeBarang.text = modelC.barang.value.data!.kodebarang!;
      namaBarang.text = modelC.barang.value.data!.namabarang!;
    }
  }

  updateBarang()async{
    Dio.FormData formData = Dio.FormData.fromMap({
      'kodebarang':kodeBarang.text,
      'namabarang':namaBarang.text
    });

    final response = await dio.put('/barang/${Get.arguments}',
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
      await detailC.getBarang();
      Get.back();
    }
  }
}
