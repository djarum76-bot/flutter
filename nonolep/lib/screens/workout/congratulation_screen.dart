import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nonolep/components/button/custom_app_button.dart';
import 'package:nonolep/models/workout_detail_model.dart';
import 'package:nonolep/utils/app_routes.dart';
import 'package:nonolep/utils/app_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CongratulationScreen extends StatelessWidget{
  const CongratulationScreen({super.key, required this.workoutActivityModel});
  final List<WorkoutActivityModel> workoutActivityModel;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashboardScreen, (route) => false);
        return Future.value(false);
      },
      child: Scaffold(
        body: _congratulationBody(context),
      ),
    );
  }

  Widget _congratulationBody(BuildContext context){
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Column(
          children: [
            _congratulationUpperSection(),
            SizedBox(height: 4.h,),
            _congratulationHomeButton(context)
          ],
        ),
      ),
    );
  }

  Widget _congratulationUpperSection(){
    return Expanded(
      child: Column(
        children: [
          Icon(LineIcons.trophy, color: Colors.amberAccent, size: 40.vmax,),
          Text(
            "Congratulations",
            style: GoogleFonts.urbanist(color: AppTheme.primaryColor, fontWeight: FontWeight.w700, fontSize: 24.sp),
          ),
          SizedBox(height: 3.h,),
          Text(
            "You have completed the workout",
            style: GoogleFonts.urbanist(fontWeight: FontWeight.w500, fontSize: 17.sp, color: Colors.white),
          ),
          SizedBox(height: 4.h,),
          Container(
            height: 0.1.h,
            width: double.infinity,
            color: AppTheme.separatorLineColor,
          ),
          SizedBox(height: 4.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _congratulationWorkoutInformation(title: workoutActivityModel.length.toString(), subtitle: "Workout"),
              SizedBox(width: 10.w,),
              _congratulationWorkoutInformation(title: "340", subtitle: "Cal"),
            ],
          )
        ],
      ),
    );
  }

  Widget _congratulationWorkoutInformation({required String title, required String subtitle}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 24.sp),
        ),
        Text(
          subtitle,
          style: GoogleFonts.urbanist(fontWeight: FontWeight.w600, fontSize: 17.sp, color: Colors.white),
        )
      ],
    );
  }

  Widget _congratulationHomeButton(BuildContext context){
    return CustomAppButton(
      loading: false,
      height: 6.h,
      backgroundColor: AppTheme.ringTimerColor,
      borderColor: AppTheme.ringTimerColor,
      onTap: () => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashboardScreen, (route) => false),
      label: "Home",
    );
  }
}