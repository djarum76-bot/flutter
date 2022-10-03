import 'package:crudgolang/app/controllers/models_controller.dart';
import 'package:crudgolang/app/controllers/sevice_controller.dart';
import 'package:crudgolang/app/models/barang_model.dart';
import 'package:crudgolang/app/modules/home/controllers/home_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final modelC = Get.find<ModelsController>();

  final kodebarang = "".obs;
  final namabarang = "".obs;

  final homeC = Get.find<HomeController>();

  getBarang()async{
    final response = await dio.get('/barang/${Get.arguments}',
        options: Options(
            headers: {
              "Accept": "application/json"
            }
        )
    );

    final data = response.data;

    if(response.statusCode == 200){
      modelC.barang(BarangModel.fromJson(data));
      modelC.barang.refresh();

      kodebarang.value = modelC.barang.value.data!.kodebarang!;
      namabarang.value = modelC.barang.value.data!.namabarang!;
    }
  }

  deleteBarang()async{
    final response = await dio.delete('/barang/${Get.arguments}',
        options: Options(
            headers: {
              "Accept": "application/json"
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
