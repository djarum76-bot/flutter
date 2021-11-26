import 'package:amaly/app/custom/CustomAppBarAlQuran.dart';
import 'package:amaly/app/modules/isisurat/controllers/isisurat_controller.dart';
import 'package:amaly/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../controllers/daftarsurat_controller.dart';

class DaftarsuratView extends GetView<DaftarsuratController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBarAlQuran(msg: "Baca Qur'an"),
            SizedBox(height: 10,),
            DefaultTabController(
                length: 2,
                initialIndex: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      child: TabBar(
                          labelColor: Color(0xFF1DAD9B),
                          unselectedLabelColor: Colors.grey,
                          labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 18),
                          unselectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 18),
                          tabs: [
                            Tab(
                              text: "Surat",
                            ),
                            Tab(
                              text: "Juz",
                            ),
                          ]
                      ),
                    ),
                    Container(
                      height: Get.height * 0.7,
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      child: TabBarView(
                          children: [
                            Container(
                              child: ListView.builder(
                                  itemCount: 114,
                                  itemBuilder: (context, index){
                                    return ListTile(
                                      onTap: (){
                                        Get.toNamed(Routes.ISISURAT);
                                      },
                                      leading: Stack(
                                        children: [
                                          Image.asset("asset/icon/nomor.png",width: Get.width * 0.1,),
                                          Positioned(
                                              bottom: index < 99 ? Get.width * 0.026 : Get.width * 0.026,
                                              right: index < 99 ? Get.width * 0.032 : Get.width * 0.025,
                                              child: Text(
                                                  "${index + 1}",
                                                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF1DAD9B)),
                                              )
                                          )
                                        ],
                                      ),
                                      title: Text(
                                        "Nama Surat",
                                        style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 18, color: Color(0xFF1DAD9B))
                                      ),
                                      subtitle: Text(
                                          "Arti Surat - Jumlah Ayat",
                                          style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xFF8789A3))
                                      ),
                                      trailing: Text(
                                          "Nama Surat",
                                          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 20, color: Color(0xFF1DAD9B))
                                      ),
                                    );
                                  }
                              ),
                            ),
                            Container(
                              child: Center(
                                child: Lottie.asset("asset/lottie/404.json"),
                              ),
                            ),
                          ]
                      ),
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}