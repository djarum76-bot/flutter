import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppTheme{
  static ThemeData theme(){
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldColor,
      primarySwatch: createMaterialColor(primaryColor),
      colorScheme: ColorScheme.fromSwatch(
          primarySwatch: createMaterialColor(primaryColor)
      ),
    );
  }

  static InputDecoration inputDecoration({required String hintText, double radius = 12}){
    return InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide.none
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: primaryColor)
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: hintColor, fontSize: 16.sp),
        filled: true,
        fillColor: onScaffoldColor,
        contentPadding: EdgeInsets.fromLTRB(4.w, 3.h, 4.w, 0)
    );
  }

  static InputDecoration inputPrefixIconDecoration({required IconData icon, required String hintText, double radius = 12}){
    return InputDecoration(
      prefixIcon: Icon(icon, color: hintColor, size: 3.vmax),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide.none
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: primaryColor)
      ),
      hintText: hintText,
      hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: hintColor),
      filled: true,
      fillColor: onScaffoldColor,
      contentPadding: EdgeInsets.fromLTRB(2.w, 3.h, 2.w, 0)
    );
  }

  static InputDecoration inputSuffixIconDecoration({required IconData icon, required String hintText, double radius = 12}){
    return InputDecoration(
        suffixIcon: Icon(icon, color: hintColor, size: 3.vmax),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide.none
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: primaryColor)
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: hintColor, fontSize: 16.sp),
        filled: true,
        fillColor: onScaffoldColor,
        contentPadding: EdgeInsets.fromLTRB(4.w, 3.h, 4.w, 0)
    );
  }

  static InputDecoration inputSearchDecoration({required void Function() onTap, double radius = 12}){
    return InputDecoration(
        prefixIcon: Icon(LineIcons.search, color: hintColor, size: 3.vmax),
        suffixIcon: GestureDetector(
          onTap: onTap,
          child: Icon(Icons.highlight_remove_rounded, color: hintColor, size: 3.vmax),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide.none
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: primaryColor)
        ),
        hintText: "Search",
        hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: hintColor),
        filled: true,
        fillColor: onScaffoldColor,
        contentPadding: EdgeInsets.fromLTRB(2.w, 3.h, 2.w, 0)
    );
  }

  static InputDecoration inputPhoneDecoration({required String hintText, double radius = 12}){
    return InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(top: 1.75.h, left: 4.w, right: 3.w),
          child: Text(
            "+62",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: hintColor),
          ),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide.none
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: primaryColor)
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: hintColor),
        filled: true,
        fillColor: onScaffoldColor,
        contentPadding: EdgeInsets.fromLTRB(4.w, 3.h, 4.w, 0)
    );
  }

  static InputDecoration inputPasswordDecoration({required bool state, required void Function()? onTap, required String hintText, double radius = 12}){
    return InputDecoration(
        prefixIcon: Icon(LineIcons.lock, color: hintColor),
        suffixIcon: IconButton(
          onPressed: onTap,
          icon: Icon(state ? Ionicons.eye_off_outline : Ionicons.eye_outline, color: hintColor),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide.none
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: primaryColor)
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: hintColor),
        filled: true,
        fillColor: onScaffoldColor,
        contentPadding: EdgeInsets.fromLTRB(2.w, 3.h, 2.w, 0)
    );
  }

  static ButtonStyle elevatedButton(double radius){
    return ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        )
    );
  }

  static Color primaryColor = const Color(0xFF6842ff);
  static Color scaffoldColor = const Color(0xFF181a20);
  static Color hintColor = const Color(0xFF7e7f81);
  static Color dotColor = const Color(0xFF35383f);
  static Color greyTextColor = const Color(0xFFe8e8e8);
  static Color greyIconColor = const Color(0xFF9e9e9e);
  static Color onScaffoldColor = const Color(0xFF1f222a);
  static Color greyBorderColor = const Color(0xFF35383f);
  static Color separatorLineColor = const Color(0xFF26292f);
  static Color redColor = const Color(0xFFB64967);
  static Color successColor = const Color(0xFF24c468);
  static Color workoutColor = const Color(0xFF3174fd);
  static Color featureColor = const Color(0xFFff656a);
  static Color inactiveDotColor = const Color(0xFFe0e0e0);
  static Color ringTimerColor = const Color(0xFF35383f);
  static Color historyColor = const Color(0xFFbdbdbd);
  static Color redRingColor = const Color(0xFFfe676b);
  static Color yellowRingColor = const Color(0xFFfacf24);

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}