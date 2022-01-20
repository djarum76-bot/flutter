import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormAlamat extends StatelessWidget {
  const TextFormAlamat({
    Key? key, required this.label, this.controller
  }) : super(key: key);

  final String label;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.065,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFFF1F6FB)
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.04,vertical: Get.width * 0.04),
            border: InputBorder.none,
            hintText: label,
        ),
        style: GoogleFonts.inter(fontSize: 14,fontWeight: FontWeight.w500, color: Color(0xFF8B90A9)),
      ),
    );
  }
}