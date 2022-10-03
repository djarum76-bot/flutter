import 'package:crudgolang/app/controllers/models_controller.dart';
import 'package:crudgolang/app/controllers/sevice_controller.dart';
import 'package:crudgolang/app/models/barangs_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final modelC = Get.find<ModelsController>();
  final jumlah = 0.obs;

  final id = <int>[].obs;
  final kodeBarang = <String>[].obs;
  final namaBarang = <String>[].obs;

  getAllBarang()async{
    final response = await dio.get('/barang',
        options: Options(
            headers: {
              "Accept": "application/json"
            }
        )
    );

    final data = response.data;

    if(response.statusCode == 200){
      modelC.barangs(BarangsModel.fromJson(data));
      modelC.barangs.refresh();

      jumlah.value = modelC.barangs.value.data!.length;

      id.clear();
      kodeBarang.clear();
      namaBarang.clear();

      for(int i=0;i<modelC.barangs.value.data!.length;i++){
        id.add(modelC.barangs.value.data![i].id!);
        id.refresh();

        kodeBarang.add(modelC.barangs.value.data![i].kodebarang!);
        kodeBarang.refresh();

        namaBarang.add(modelC.barangs.value.data![i].namabarang!);
        namaBarang.refresh();
      }
    }
  }
}
