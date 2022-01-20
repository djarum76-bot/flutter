import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key, this.msg,
  }) : super(key: key);

  final String? msg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 30),
      height: Get.height * 0.11,
      color: Color(0xFFFFFFFF),
      child: Row(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            width: Get.width * 0.09,
            height: Get.width * 0.09,
            child: Align(
              child: IconButton(
                  onPressed: (){
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back_ios, color: Colors.black,size: 25,)
              ),
              alignment: Alignment.centerRight,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: Color(0xFFD0D0D0)
                )
            ),
          ),
          SizedBox(width: 30,),
          msg == null
              ? Container()
              : Text(
                  msg!,
                  style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF1E3354)),
                )
        ],
      ),
    );
  }
}