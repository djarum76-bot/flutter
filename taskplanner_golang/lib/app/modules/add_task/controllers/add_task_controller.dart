import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskplanner/app/controllers/auth_controller.dart';
import 'package:taskplanner/app/modules/home/controllers/home_controller.dart';
import 'package:taskplanner/app/modules/task/controllers/task_controller.dart';

class AddTaskController extends GetxController {
  late TextEditingController title;
  // late TextEditingController date;
  // late TextEditingController time;
  late TextEditingController desc;

  final selectedDate = DateTime.now().obs;
  final selectedTime = TimeOfDay.now().obs;

  final selectedDateAndTime = DateTime.now().obs;

  final tgl = "".obs;
  final waktu = "".obs;

  final authC = Get.find<AuthController>();
  final taskC = Get.find<TaskController>();
  final homeC = Get.find<HomeController>();

  void onTimeChanged(TimeOfDay newTime) {
    selectedTime.value = newTime;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    title = TextEditingController();
    // date = TextEditingController();
    // time = TextEditingController();
    desc = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    title.dispose();
    // time.dispose();
    // date.dispose();
    desc.dispose();
  }

  Future<void> addTask()async{
    Dio.FormData formData = Dio.FormData.fromMap({
      'title':title.text,
      'date':selectedDateAndTime.value,
      'tanggal':tgl.value,
      'waktu':waktu.value,
      'deskripsi':desc.text
    });

    final response = await dio.post('/auth/task',
        data: formData,
        options: Dio.Options(
            headers: {
              "Accept": "application/json",
              "Authorization": "bearer ${authC.box.read('token')}"
            }
        )
    );

    final data = response.data;

    if(response.statusCode == 200){
      // await taskC.getTasks();
      // await homeC.getTasks();
      Get.back();
    }else{
      authC.getNewToken(addTask);
    }
  }
}
