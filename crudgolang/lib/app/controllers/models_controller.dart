import 'package:crudgolang/app/models/barang_model.dart';
import 'package:crudgolang/app/models/barangs_model.dart';
import 'package:get/get.dart';

class ModelsController extends GetxController {
  final barangs = BarangsModel().obs;
  final barang = BarangModel().obs;
}
