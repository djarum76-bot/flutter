import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nonolep/components/button/custom_app_button.dart';
import 'package:nonolep/components/button/start_button_for_workout.dart';
import 'package:nonolep/components/workout_activity_item.dart';
import 'package:nonolep/models/workout_detail_model.dart';
import 'package:nonolep/models/workout_model.dart';
import 'package:nonolep/utils/app_routes.dart';
import 'package:nonolep/utils/app_theme.dart';
import 'package:nonolep/utils/screen_argument.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WorkoutDetailScreen extends StatelessWidget{
  const WorkoutDetailScreen({super.key, required this.workoutModel});
  final WorkoutModel workoutModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _workoutDetailBody(context),
    );
  }

  Widget _workoutDetailBody(BuildContext context){
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _workoutDetailUpperSection(context),
                    _workoutDetailMiddleSection(context),
                  ],
                ),
              ),
            ),
            StartButtonForWorkout(workoutActivityModel: workoutModel.workoutActivity)
          ],
        ),
      ),
    );
  }

  Widget _workoutDetailUpperSection(BuildContext context){
    return SizedBox(
      width: double.infinity,
      height: 30.h,
      child: Stack(
        children: [
          _workoutDetailSwiper(),
          _workoutDetailButtonAction(context)
        ],
      ),
    );
  }

  Widget _workoutDetailSwiper(){
    return SizedBox(
      width: double.infinity,
      height: 30.h,
      child: Swiper(
        itemBuilder: (context, index){
          return Stack(
            children: [
              Container(
                width: double.infinity,
                height: 30.h,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(workoutModel.workoutActivity[index].image),
                        fit: BoxFit.cover
                    )
                ),
              ),
              Container(
                width: double.infinity,
                height: 30.h,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black38,
                        Colors.transparent,
                      ]
                  )
                ),
              )
            ],
          );
        },
        itemCount: workoutModel.workoutActivity.length,
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            activeColor: AppTheme.primaryColor,
            color: AppTheme.inactiveDotColor,
          )
        ),
        controller: SwiperController(),
        autoplay: false,
        loop: true,
      ),
    );
  }

  Widget _workoutDetailButtonAction(BuildContext context){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back, size: 3.5.vmax, color: Colors.white,),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: (){},
                child: Icon(Icons.bookmark_outline_rounded, size: 3.5.vmax, color: Colors.white,),
              ),
              SizedBox(width: 2.w,),
              GestureDetector(
                onTap: (){},
                child: Icon(Icons.pending_outlined, size: 3.5.vmax, color: Colors.white,),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _workoutDetailMiddleSection(BuildContext context){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(4.w, 3.h, 4.w, 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            workoutModel.title,
            style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 23.sp),
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2.5.h,),
          _workoutDetailInformation(),
          SizedBox(height: 2.5.h,),
          Container(
            height: 0.1.h,
            width: double.infinity,
            color: AppTheme.separatorLineColor,
          ),
          SizedBox(height: 2.5.h,),
          _workoutDetailActivityTitle(context),
          SizedBox(height: 2.h,),
          _workoutDetailActivitySection()
        ],
      ),
    );
  }

  Widget _workoutDetailInformation(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomAppButton(
              height: 4.25.h,
              loading: false,
              backgroundColor: AppTheme.scaffoldColor,
              borderColor: AppTheme.primaryColor,
              label: "Beginner",
              textColor: AppTheme.primaryColor,
              onTap: null,
              fontSize: 14.sp
          ),
        ),
        SizedBox(width: 3.w,),
        Expanded(
          child: CustomAppButton(
              height: 4.25.h,
              loading: false,
              backgroundColor: AppTheme.scaffoldColor,
              borderColor: AppTheme.primaryColor,
              label: "${workoutModel.minute} minutes",
              iconData: LineIcons.clock,
              iconSize: 2.vmax,
              iconColor: AppTheme.primaryColor,
              textColor: AppTheme.primaryColor,
              onTap: null,
              fontSize: 14.sp
          ),
        ),
        SizedBox(width: 3.w,),
        Expanded(
          child: CustomAppButton(
              height: 4.25.h,
              loading: false,
              backgroundColor: AppTheme.scaffoldColor,
              borderColor: AppTheme.primaryColor,
              label: "${workoutModel.workoutActivity.length} workout",
              iconData: LineIcons.clock,
              iconSize: 2.vmax,
              iconColor: AppTheme.primaryColor,
              textColor: AppTheme.primaryColor,
              onTap: null,
              fontSize: 14.sp
          ),
        )
      ],
    );
  }

  Widget _workoutDetailActivityTitle(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Workout Activity",
          style: GoogleFonts.urbanist(fontWeight: FontWeight.w600, fontSize: 18.sp, color: Colors.white),
        ),
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(
              context,
              AppRoutes.allWorkoutActivityScreen,
              arguments: ScreenArgument<List<WorkoutActivityModel>>(workoutModel.workoutActivity)
            );
          },
          child: Text(
            "See All",
            style: GoogleFonts.urbanist(fontWeight: FontWeight.w600, fontSize: 17.sp, color: AppTheme.primaryColor),
          ),
        )
      ],
    );
  }

  Widget _workoutDetailActivitySection(){
    return Wrap(
      children: _workoutDetailActivityList(),
    );
  }

  List<Widget> _workoutDetailActivityList(){
    List<Widget> list = <Widget>[];

    for(int i = 0; i < workoutModel.workoutActivity.length / 2; i++){
      list.add(WorkoutActivityItem(workoutActivityModel: workoutModel.workoutActivity[i]));
    }

    return list;
  }
}