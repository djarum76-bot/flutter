import 'package:dio/dio.dart' as Dio;
import 'package:get/get.dart';
import 'package:taskplanner/app/controllers/auth_controller.dart';
import 'package:taskplanner/app/controllers/model_controller.dart';
import 'package:taskplanner/app/models/tasks_model.dart';
import 'package:taskplanner/app/models/user_model.dart';

class HomeController extends GetxController {
  final modelC = Get.find<ModelController>();
  final authC = Get.find<AuthController>();

  //user
  final name = "".obs;
  final role = "".obs;
  final roleValid = false.obs;
  final image = "".obs;
  final imageValid = false.obs;

  //task
  final judul = <String>[].obs;
  final tanggal = <String>[].obs;
  final waktu = <String>[].obs;
  final id = <int>[].obs;
  final jumlah = 0.obs;

  Future<void> getUser()async{
    final response = await dio.get('/auth/user',
      options: Dio.Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "bearer ${authC.box.read('token')}"
        }
      )
    );

    final data = response.data;

    if(response.statusCode == 200){
      modelC.user(UserModel.fromJson(data));
      modelC.user.refresh();

      name.value = modelC.user.value.data!.username!;
      name.refresh();

      role.value = modelC.user.value.data!.role!.string!;
      role.refresh();
      roleValid.value = modelC.user.value.data!.role!.valid!;
      roleValid.refresh();

      image.value = modelC.user.value.data!.image!.string!;
      image.refresh();
      imageValid.value = modelC.user.value.data!.image!.valid!;
      imageValid.refresh();
    }else{
      authC.getNewToken(getUser);
    }
  }

  Future<void> getAllTask()async{
    final response = await dio.get('/auth/task',
        options: Dio.Options(
            headers: {
              "Accept": "application/json",
              "Authorization": "bearer ${authC.box.read('token')}"
            }
        )
    );

    final data = response.data;

    if(response.statusCode == 200){
      modelC.tasks(TasksModel.fromJson(data));
      modelC.tasks.refresh();

      jumlah.value = modelC.tasks.value.data!.length;

      judul.clear();
      tanggal.clear();
      waktu.clear();
      id.clear();
      for(int i=0;i<modelC.tasks.value.data!.length;i++){
        judul.add(modelC.tasks.value.data![i].title!);
        judul.refresh();

        tanggal.add(modelC.tasks.value.data![i].tanggal!);
        tanggal.refresh();

        waktu.add(modelC.tasks.value.data![i].waktu!);
        waktu.refresh();

        id.add(modelC.tasks.value.data![i].id!);
        id.refresh();
      }
    }else{
      authC.getNewToken(getAllTask);
    }
  }
}
