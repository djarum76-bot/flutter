import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nonolep/utils/app_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomAppBar{
  static AppBar withLogoApp({required String title, List<Widget> actions = const <Widget>[]}){
    return AppBar(
      automaticallyImplyLeading: false,
      leading: Container(
        padding: EdgeInsets.fromLTRB(4.w, 1.25.h, 1.w, 1.25.h),
        child: Container(
          width: 10.w,
          height: 5.h,
          decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(12)
          ),
          child: Center(
            child: Icon(LineIcons.dumbbell, size: 3.25.vmax, color: Colors.white,),
          ),
        ),
      ),
      leadingWidth: 15.w,
      title: Text(
        title,
        style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20.sp),
      ),
      titleSpacing: 2.w,
      actions: actions,
      backgroundColor: AppTheme.scaffoldColor,
      elevation: 0,
    );
  }

  static AppBar withArrowBackLogo({required String title, List<Widget> actions = const <Widget>[]}){
    return AppBar(
      leadingWidth: 15.w,
      title: Text(
        title,
        style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20.sp),
      ),
      titleSpacing: 1.w,
      actions: actions,
      backgroundColor: AppTheme.scaffoldColor,
      elevation: 0,
    );
  }
}