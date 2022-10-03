import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key, required this.msg,
  }) : super(key: key);

  final String msg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * 0.13,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: Color(0xFF1DAD9B)
      ),
      padding: EdgeInsets.all(20),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            width: Get.width * 0.13,
            height: Get.width * 0.13,
            child: Align(
              child: IconButton(
                  onPressed: (){
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white)
              ),
              alignment: Alignment.bottomCenter,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFF9BF4D5).withOpacity(0.37)
            ),
          ),
          Center(
            child: Text(
              msg,
              style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFFFFFFFF)),
            ),
          )
        ],
      ),
    );
  }
}