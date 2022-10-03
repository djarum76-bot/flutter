import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:taskplanner/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5EEDC),
      body: SafeArea(
          child: FutureBuilder(
              future: controller.getUser(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  return Column(
                    children: [
                      Header(),
                      Body()
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
          )
      ),
    );
  }
}

class Header extends GetView<HomeController> {
  const Header({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * 0.25,
      decoration: BoxDecoration(
          color: Color(0xffFABB51),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          )
      ),
      padding: EdgeInsets.all(Get.height * 0.03),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx((){
            return controller.imageValid.value
                ? Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle
                    ),
                    height: Get.height * 0.14,
                    width: Get.height * 0.14,
                  )
                : Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle
                    ),
                    height: Get.height * 0.14,
                    width: Get.height * 0.14,
                  );
          }),
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx((){
                    return Text(
                      "${controller.name.value}",
                      style: GoogleFonts.righteous(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),
                    );
                  }),
                  Obx((){
                    return controller.roleValid.value
                        ? Text(
                            "${controller.role.value}",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )
                        : Text(
                            "Profesi",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          );
                  })
                ],
              )
          )
        ],
      ),
    );
  }
}

class Body extends GetView<HomeController> {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Get.height * 0.025, vertical: Get.height * 0.015),
          child: ListView(
            children: [
              IniTask(),
              SizedBox(height: 10,),
              IniNote()
            ],
          ),
        )
    );
  }
}

class IniTask extends GetView<HomeController> {
  const IniTask({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Urgent Task",
                style: GoogleFonts.righteous(fontSize: 24),
              ),
              CircleAvatar(
                child: IconButton(
                    onPressed: (){
                      Get.toNamed(Routes.TASK);
                    },
                    icon: Icon(Icons.calendar_today)
                ),
              )
            ],
          ),
          SizedBox(height: 10,),
          Container(
            child: FutureBuilder(
                future: controller.getAllTask(),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.done){
                    return Obx((){
                      return controller.jumlah.value != 0
                          ? ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.jumlah.value > 3 ? 3 : controller.jumlah.value,
                                itemBuilder: (context, index){
                                  return ListTile(
                                    onTap: (){
                                      Get.toNamed(Routes.DETAIL_TASK, arguments: controller.id.value[index]);
                                    },
                                    title: Text("${controller.judul.value[index]}", style: GoogleFonts.righteous(),),
                                    subtitle: Text("${DateFormat('EEE, d MMM yyyy').format(DateTime.parse(controller.tanggal.value[index]))} ${controller.waktu.value[index]}"),
                                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.black,),
                                  );
                                }
                            )
                          : Container(
                              width: Get.width,
                              height: Get.height * 0.2647,
                              child: Center(
                                child: Text(
                                    "Belum ada perencanaan"
                                ),
                              ),
                            );
                    });
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
            ),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}

class IniNote extends GetView<HomeController> {
  const IniNote({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Important Note",
                style: GoogleFonts.righteous(fontSize: 24),
              ),
              CircleAvatar(
                child: IconButton(
                    onPressed: (){
                      Get.toNamed(Routes.NOTE);
                    },
                    icon: Icon(Icons.note)
                ),
              )
            ],
          ),
          SizedBox(height: 10,),
          Container(
            child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 2,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                shrinkWrap: true,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      Get.toNamed(Routes.DETAIL_NOTE);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xffFABB51),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      padding: EdgeInsets.all(Get.height * 0.02),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Utang",
                          style: GoogleFonts.righteous(fontSize: 22, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }
            ),
          )
        ],
      ),
    );
  }
}