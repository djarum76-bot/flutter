import 'package:crudgolang/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: controller.getAllBarang(),
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else{
              return Obx((){
                return controller.jumlah.value != 0
                    ? ListView.builder(
                        itemBuilder: (context,index){
                          return InkWell(
                            onTap: (){
                              Get.toNamed(Routes.DETAIL, arguments: controller.id.value[index]);
                            },
                            child: Card(
                              child: ListTile(
                                title: Text("${controller.kodeBarang.value[index]}"),
                                subtitle: Text("${controller.namaBarang.value[index]}"),
                              ),
                            ),
                          );
                        },
                        itemCount: controller.modelC.barangs.value.data!.length,
                      )
                    : Center(
                        child: Text("Tidak ada data"),
                      );
              });
            }
          }
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Get.toNamed(Routes.ADD);
          }
      ),
    );
  }
}
