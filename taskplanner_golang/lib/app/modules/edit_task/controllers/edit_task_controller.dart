import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditTaskController extends GetxController {
  late TextEditingController title;
  late TextEditingController date;
  late TextEditingController time;
  late TextEditingController desc;

  final selectedDate = DateTime.now().obs;
  final selectedTime = TimeOfDay.now().obs;

  void onTimeChanged(TimeOfDay newTime) {
    selectedTime.value = newTime;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    title = TextEditingController();
    date = TextEditingController();
    time = TextEditingController();
    desc = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    title.dispose();
    time.dispose();
    date.dispose();
    desc.dispose();
  }
}
