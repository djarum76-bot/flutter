import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nonolep/components/blurry_container.dart';
import 'package:nonolep/models/workout_model.dart';
import 'package:nonolep/utils/app_routes.dart';
import 'package:nonolep/utils/helpers/dummy_helper.dart';
import 'package:nonolep/utils/screen_argument.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WorkoutContentItem extends StatelessWidget{
  final int? index;
  final bool isHorizontal;
  final bool isGrid;
  final String? level;

  const WorkoutContentItem({
    super.key,
    this.index,
    required this.isHorizontal,
    this.isGrid = false,
    this.level
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(
          context,
          AppRoutes.workoutDetailScreen,
          arguments: ScreenArgument<WorkoutModel>(DummyHelper.workouts[index!])
        );
      },
      child: _workoutContentItem(),
    );
  }

  Widget _workoutContentItem(){
    if(isHorizontal){
      return Container(
        height: 30.h,
        width: 60.w,
        margin: isGrid ? EdgeInsets.zero : EdgeInsets.only(left: 4.w, right: index == DummyHelper.workouts.length - 1 ? 4.w : 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            image: DecorationImage(
                image: AssetImage(DummyHelper.workouts[index!].image),
                fit: BoxFit.cover
            )
        ),
        child: Stack(
          children: [
            BlurryContainer(height: 15.h),
            _workoutContentItemData(index!)
          ],
        ),
      );
    }else{
      return Container(
        height: 17.5.h,
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(4.w, 0, 4.w, 2.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            image: DecorationImage(
                image: AssetImage(DummyHelper.workouts[index!].image),
                fit: BoxFit.cover
            )
        ),
        child: Stack(
          children: [
            BlurryContainer(height: 15.h),
            _workoutContentItemData(index!)
          ],
        ),
      );
    }
  }

  Widget _workoutContentItemData(int index){
    if(isGrid){
      return Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DummyHelper.workouts[index].title,
              style: GoogleFonts.urbanist(fontWeight: FontWeight.w600, fontSize: 19.5.sp, color: Colors.white),
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 0.5.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${DummyHelper.workouts[index].minute} minutes}",
                      style: GoogleFonts.urbanist(fontWeight: FontWeight.w400, fontSize: 15.sp, color: Colors.white),
                    ),
                    Text(
                      level ?? "Intermediate",
                      style: GoogleFonts.urbanist(fontWeight: FontWeight.w400, fontSize: 15.sp, color: Colors.white),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: (){},
                  child: Icon(Icons.bookmark_rounded, size: 3.25.vmax, color: Colors.white,),
                )
              ],
            )
          ],
        ),
      );
    }else{
      return Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DummyHelper.workouts[index].title,
              style: GoogleFonts.urbanist(fontWeight: FontWeight.w600, fontSize: 19.5.sp, color: Colors.white),
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 0.5.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${DummyHelper.workouts[index].minute} minutes  |  ${level ?? "Intermediate"}",
                  style: GoogleFonts.urbanist(fontWeight: FontWeight.w400, fontSize: 15.sp, color: Colors.white),
                ),
                GestureDetector(
                  onTap: (){},
                  child: Icon(Icons.bookmark_outline_rounded, size: 3.25.vmax, color: Colors.white,),
                )
              ],
            )
          ],
        ),
      );
    }
  }
}