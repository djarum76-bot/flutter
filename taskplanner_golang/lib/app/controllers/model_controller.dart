import 'package:get/get.dart';
import 'package:taskplanner/app/models/task_date_model.dart';
import 'package:taskplanner/app/models/tasks_model.dart';
import 'package:taskplanner/app/models/user_model.dart';

class ModelController extends GetxController {
  final user = UserModel().obs;

  final tasks = TasksModel().obs;
  final taskdate = TaskDateModel().obs;
}
