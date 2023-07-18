import 'package:flutter/material.dart';
import 'package:nonolep/components/button/custom_app_button.dart';
import 'package:nonolep/models/workout_detail_model.dart';
import 'package:nonolep/utils/app_routes.dart';
import 'package:nonolep/utils/app_theme.dart';
import 'package:nonolep/utils/screen_argument.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class StartButtonForWorkout extends StatelessWidget{
  const StartButtonForWorkout({super.key, required this.workoutActivityModel});
  final List<WorkoutActivityModel> workoutActivityModel;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 20,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32),
      ),
      child: Container(
        width: double.infinity,
        height: 10.h,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: AppTheme.scaffoldColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Center(
          child: CustomAppButton(
            height: 6.h,
            loading: false,
            label: "START",
            onTap: (){
              Navigator.pushNamed(
                  context,
                  AppRoutes.workoutActivityScreen,
                  arguments: ScreenArgument<List<WorkoutActivityModel>>(workoutActivityModel)
              );
            },
          ),
        ),
      ),
    );
  }
}