import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TextForm extends StatelessWidget {
  const TextForm({
    Key? key, required this.label, this.suffix, this.controller, required this.secure,
  }) : super(key: key);

  final String label;
  final Widget? suffix;
  final TextEditingController? controller;
  final bool secure;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.08,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFFF1F6FB)
      ),
      child: TextField(
        controller: controller,
        obscureText: secure,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.04,vertical: Get.width * 0.06),
            border: InputBorder.none,
            hintText: label,
            suffixIcon: suffix,
        ),
        style: GoogleFonts.inter(fontSize: 14,fontWeight: FontWeight.w500, color: Color(0xFF8B90A9)),
      ),
    );
  }
}