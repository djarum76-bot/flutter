import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nonolep/models/workout_detail_model.dart';
import 'package:nonolep/utils/app_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WorkoutActivityItem extends StatelessWidget{
  const WorkoutActivityItem({super.key, required this.workoutActivityModel});
  final WorkoutActivityModel workoutActivityModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 15.h,
      margin: EdgeInsets.only(bottom: 2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: AppTheme.onScaffoldColor,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    bottomLeft: Radius.circular(32),
                  ),
                  image: DecorationImage(
                      image: AssetImage(workoutActivityModel.image),
                      fit: BoxFit.cover
                  )
              ),
            ),
          ),
          SizedBox(width: 3.w,),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  workoutActivityModel.title,
                  style: GoogleFonts.urbanist(fontWeight: FontWeight.w600, fontSize: 18.sp, color: Colors.white),
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 1.h,),
                Text(
                  "${workoutActivityModel.duration} seconds",
                  style: GoogleFonts.urbanist(fontWeight: FontWeight.w400, fontSize: 16.sp, color: Colors.white),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}