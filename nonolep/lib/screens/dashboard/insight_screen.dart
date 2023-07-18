import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nonolep/components/custom_app_bar.dart';
import 'package:nonolep/components/custom_app_dialog.dart';
import 'package:nonolep/components/workout_content_item.dart';
import 'package:nonolep/utils/app_theme.dart';
import 'package:nonolep/utils/helpers/dummy_helper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class InsightScreen extends StatefulWidget{
  const InsightScreen({super.key});

  @override
  State<InsightScreen> createState() => _InsightScreenState();
}

class _InsightScreenState extends State<InsightScreen> {
  late DateTime _date;
  late DateTime _now;

  @override
  void initState() {
    _date = DateTime.now();
    _now = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => CustomAppDialog.exitApplication(context),
      child: Scaffold(
        appBar: CustomAppBar.withLogoApp(
            title: "Insight",
            actions: [
              GestureDetector(
                onTap: (){},
                child: Icon(Icons.pending_outlined, size: 3.5.vmax, color: Colors.white,),
              ),
              SizedBox(width: 2.45.w,),
            ]
        ),
        body: _insightBody(context),
      ),
    );
  }

  Widget _insightBody(BuildContext context){
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              CalendarAppBar(
                backButton: false,
                onDateChanged: (value){},
                selectedDate: _date,
                lastDate: _now,
                white: AppTheme.primaryColor,
                black: Colors.white,
                accent: AppTheme.scaffoldColor,
                padding: 0,
              ),
              _insightChart(
                size: Size(50.w, 20.h),
                val1: 950,
                val2: 400,
                color: AppTheme.primaryColor,
                radius: 50,
                subtitle: "Cal",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 30.w,
                    height: 20.h,
                    child: _insightChart(
                      size: Size(40.w, 20.h),
                      val1: 64,
                      val2: 36,
                      color: AppTheme.yellowRingColor,
                      radius: 30,
                      subtitle: "Workout",
                      isRow: true
                    ),
                  ),
                  SizedBox(
                    width: 30.w,
                    height: 20.h,
                    child: _insightChart(
                      size: Size(40.w, 20.h),
                      val1: 50,
                      val2: 70,
                      color: AppTheme.redRingColor,
                      radius: 30,
                      subtitle: "Minutes",
                      isRow: true
                    ),
                  )
                ],
              ),
              _insightFinishedWorkoutTitle(),
              SizedBox(height: 3.h,),
              _insightFinishedWorkoutContentSection(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _insightChart({required Size size, required double val1, required double val2, required Color color, required double radius, required String subtitle, bool isRow = false}){
    return Stack(
      children: [
        AnimatedCircularChart(
          size: size,
          initialChartData: <CircularStackEntry>[
            CircularStackEntry(
              <CircularSegmentEntry>[
                CircularSegmentEntry(val1, color,),
                CircularSegmentEntry(val2, AppTheme.ringTimerColor),
              ],
            ),
          ],
          chartType: CircularChartType.Radial,
          percentageValues: false,
          holeRadius: radius,
        ),
        Positioned(
          right: 0,
          left: 0,
          bottom: 0,
          top: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                val1.toInt().toString(),
                style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w700, fontSize: isRow ? 24.sp : 26.sp),
              ),
              Text(
                subtitle,
                style: GoogleFonts.urbanist(fontWeight: FontWeight.w500, fontSize: isRow ? 15.sp : 17.sp, color: Colors.white),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _insightFinishedWorkoutTitle(){
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 4.w),
        child: Text(
          "Finished Workout",
          style: GoogleFonts.urbanist(fontWeight: FontWeight.w600, fontSize: 18.sp, color: Colors.white),
        ),
      ),
    );
  }

  Widget _insightFinishedWorkoutContentSection(BuildContext context){
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        children: _insightFinishedWorkoutContentList(),
      ),
    );
  }

  List<Widget> _insightFinishedWorkoutContentList(){
    List<Widget> list = <Widget>[];

    for(var workout in DummyHelper.workouts){
      list.add(WorkoutContentItem(index: DummyHelper.workouts.indexOf(workout), isHorizontal: false, level: DummyHelper.levels[0],));
    }

    return list;
  }
}