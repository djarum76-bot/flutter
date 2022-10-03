import 'package:dio/dio.dart' as Dio;
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskplanner/app/controllers/auth_controller.dart';
import 'package:taskplanner/app/controllers/model_controller.dart';
import 'package:taskplanner/app/models/task_date_model.dart';

class TaskController extends GetxController {
  final modelC = Get.find<ModelController>();
  final authC = Get.find<AuthController>();

  final jumlah1 = 0.obs;
  final jumlah2 = <int>[].obs;
  final judul = <String>[].obs;
  final waktu = <String>[].obs;

  Future<void> getAllTaskDate()async{
    final response = await dio.get('/auth/taskdate',
        options: Dio.Options(
            headers: {
              "Accept": "application/json",
              "Authorization": "bearer ${authC.box.read('token')}"
            }
        )
    );

    final data = response.data;

    if(response.statusCode == 200){
      modelC.taskdate(TaskDateModel.fromJson(data));
      modelC.taskdate.refresh();

      jumlah1.value = modelC.taskdate.value.data!.length;
    }else{
      authC.getNewToken(getAllTaskDate);
    }
  }
}
