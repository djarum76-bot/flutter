import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_controller.dart';

class UpdateView extends GetView<UpdateController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UpdateView'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: controller.getBarang(),
          builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.done){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Get.height * 0.015,vertical: Get.height * 0.01),
                        child: ListView(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: "Kode Barang"
                              ),
                              controller: controller.kodeBarang,
                            ),
                            SizedBox(height: 15,),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: "Nama Barang"
                              ),
                              controller: controller.namaBarang,
                            )
                          ],
                        ),
                      )
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.01, horizontal: Get.height * 0.015),
                    width: Get.width,
                    height: Get.height * 0.07,
                    child: ElevatedButton(
                      onPressed: (){
                        controller.updateBarang();
                      },
                      child: Text(
                        "Update Barang",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xFF219F94),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                    ),
                  )
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }
      ),
    );
  }
}
