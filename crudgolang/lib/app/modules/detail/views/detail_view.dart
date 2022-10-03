import 'package:crudgolang/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DetailView'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder(
            future: controller.getBarang(),
            builder: (context,snapshot){
              if (snapshot.connectionState == ConnectionState.done){
                return Container(
                  width: Get.width,
                  height: Get.height,
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Obx((){
                        return Text("${controller.kodebarang.value}",style: TextStyle(fontSize: 26));
                      }),
                      SizedBox(height: 20,),
                      Obx((){
                        return Text("${controller.namabarang.value}",style: TextStyle(fontSize: 26),);
                      }),
                      SizedBox(height: 100,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: (){
                                controller.deleteBarang();
                              },
                              child: Text("Delete")
                          ),
                          ElevatedButton(
                              onPressed: (){
                                Get.toNamed(Routes.UPDATE, arguments: Get.arguments);
                              },
                              child: Text("Update")
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }
              return CircularProgressIndicator();
            }
        ),
      ),
    );
  }
}
