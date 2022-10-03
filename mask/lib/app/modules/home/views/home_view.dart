import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 180,
              height: 180,
              padding: EdgeInsets.all(10),
              child: Image.asset('assets/mask.png'),
            ),
            Container(
              child: Text(
                "ML",
                style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: Get.width,
              height: 70,
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                  onPressed: (){
                    controller.getImage(ImageSource.camera);
                  },
                  child: Text(
                    "Camera",
                    style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal
                  ),
              ),
            ),
            Container(
              width: Get.width,
              height: 70,
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: (){
                  controller.getImage(ImageSource.gallery);
                },
                child: Text(
                  "Gallery",
                  style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.teal
                ),
              ),
            ),
            Obx((){
              return controller.loading.value == false
                  ? Container(
                    )
                  : Column(
                      children: [
                        Container(
                          width: 250,
                          height: 250,
                          child: Image.file(File(controller.selectedImagePath.value)),
                        ),
                        Text(
                          controller.predictions.value[0]['label'].toString().substring(2)
                        ),
                        Text(
                            controller.predictions.value[0]['confidence'].toString()
                        )
                      ],
                    );
            })
          ],
        ),
      ),
    );
  }
}
