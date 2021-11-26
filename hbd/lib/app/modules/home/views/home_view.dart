import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hbd/app/controllers/utama_controller.dart';
import 'package:hbd/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final utamaC = Get.put(UtamaController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: Get.width * 0.7,
          height: Get.width * 0.7,
          child: Card(
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: [
                    TextField(
                      controller: utamaC.namaC,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)
                          )
                        ),
                        labelText: "Nama"
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller: utamaC.umurC,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)
                              )
                          ),
                          labelText: "Umur"
                      ),
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(
                        onPressed: (){
                          utamaC.next(utamaC.namaC.text, utamaC.umurC.text);
                        },
                        child: Text("hmmm"),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10)
                            )
                          )
                        ),
                    )
                  ],
                ),
            ),
          ),
        ),
      ),
    );
  }
}
