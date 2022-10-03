import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_controller.dart';

class AddView extends GetView<AddController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AddView'),
        centerTitle: true,
      ),
      body: Column(
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
                controller.addBarang();
              },
              child: Text(
                "Add Barang",
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
      ),
    );
  }
}
