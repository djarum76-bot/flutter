import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nonolep/bloc/user/user_bloc.dart';
import 'package:nonolep/components/button/custom_app_button.dart';
import 'package:nonolep/utils/app_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomAppDialog{
  static Future<bool> exitApplication(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context){
          return Dialog(
            backgroundColor: AppTheme.onScaffoldColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 4.5.w, vertical: 2.5.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "⚠️Warning",
                      style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, color: AppTheme.redColor, fontSize: 18.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 2.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Text(
                        "Are you sure you want to exit the application?",
                        style: GoogleFonts.urbanist(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 16.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 2.h,),
                    CustomAppButton(
                      loading: false,
                      label: "Yes",
                      onTap: () => SystemNavigator.pop(animated: true),
                      radius: 12,
                      height: 6.h,
                      backgroundColor: AppTheme.redColor,
                    ),
                    SizedBox(height: 2.h,),
                    CustomAppButton(
                      loading: false,
                      label: "No",
                      height: 6.h,
                      onTap: () => Navigator.pop(context),
                      radius: 12,
                      textColor: Colors.white,
                      backgroundColor: AppTheme.onScaffoldColor,
                    )
                  ],
                ),
              ),
            ),
          );
        }
    ) ?? false;
  }

  static Future<bool> errorDialog(BuildContext context, {required String message}) async {
    return await showDialog(
        context: context,
        builder: (context){
          return Dialog(
            backgroundColor: AppTheme.onScaffoldColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 4.5.w, vertical: 2.5.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Error",
                      style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, color: AppTheme.redColor, fontSize: 18.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 2.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Text(
                        message,
                        style: GoogleFonts.urbanist(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 16.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    ) ?? false;
  }

  static Future<bool> loadingDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return Dialog(
            backgroundColor: AppTheme.onScaffoldColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 4.5.w, vertical: 3.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LoadingAnimationWidget.inkDrop(
                      color: AppTheme.primaryColor,
                      size: 6.vmax,
                    ),
                    SizedBox(height: 3.h,),
                    Text(
                      "Please wait, thanks for the patience",
                      style: GoogleFonts.urbanist(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 18.sp),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    ) ?? false;
  }

  static Future<void> logoutDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context){
          return Dialog(
            backgroundColor: AppTheme.onScaffoldColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 4.5.w, vertical: 2.5.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "⚠️Warning",
                      style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, color: AppTheme.redColor, fontSize: 18.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 2.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Text(
                        "Are you sure you want to logout?",
                        style: GoogleFonts.urbanist(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 16.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 2.h,),
                    CustomAppButton(
                      loading: false,
                      label: "Yes",
                      onTap: () => BlocProvider.of<UserBloc>(context).add(UserLogout()),
                      radius: 12,
                      height: 6.h,
                      backgroundColor: AppTheme.redColor,
                    ),
                    SizedBox(height: 2.h,),
                    CustomAppButton(
                      loading: false,
                      label: "No",
                      height: 6.h,
                      onTap: () => Navigator.pop(context),
                      radius: 12,
                      textColor: Colors.white,
                      backgroundColor: AppTheme.onScaffoldColor,
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  static Future<void> exitActivity(BuildContext context, {required CountDownController countDownController}) async {
    return await showDialog(
        context: context,
        builder: (context){
          return Dialog(
            backgroundColor: AppTheme.onScaffoldColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 4.5.w, vertical: 2.5.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "⚠️Warning",
                      style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, color: AppTheme.redColor, fontSize: 18.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 2.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Text(
                        "Are you sure you want to exit from workout?",
                        style: GoogleFonts.urbanist(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 16.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 2.h,),
                    CustomAppButton(
                      loading: false,
                      label: "Yes",
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      radius: 12,
                      height: 6.h,
                      backgroundColor: AppTheme.redColor,
                    ),
                    SizedBox(height: 2.h,),
                    CustomAppButton(
                      loading: false,
                      label: "No",
                      height: 6.h,
                      onTap: (){
                        Navigator.pop(context);
                        countDownController.resume();
                      },
                      radius: 12,
                      textColor: Colors.white,
                      backgroundColor: AppTheme.onScaffoldColor,
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}