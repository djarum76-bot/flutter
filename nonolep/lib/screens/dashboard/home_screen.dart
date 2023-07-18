import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nonolep/components/custom_app_bar.dart';
import 'package:nonolep/components/custom_app_dialog.dart';
import 'package:nonolep/components/workout_content_item.dart';
import 'package:nonolep/components/workout_level_item.dart';
import 'package:nonolep/utils/app_routes.dart';
import 'package:nonolep/utils/app_theme.dart';
import 'package:nonolep/utils/helpers/dummy_helper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String _level;

  @override
  void initState() {
    _level = DummyHelper.levels[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => CustomAppDialog.exitApplication(context),
      child: Scaffold(
        appBar: CustomAppBar.withLogoApp(
            title: "Nonolep",
            actions: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, AppRoutes.notificationScreen),
                child: Icon(LineIcons.bell, size: 3.5.vmax, color: Colors.white,),
              ),
              SizedBox(width: 2.w,),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, AppRoutes.bookmarkScreen),
                child: Icon(Icons.bookmark_outline_rounded, size: 3.5.vmax, color: Colors.white,),
              ),
              SizedBox(width: 2.45.w,),
            ]
        ),
        body: _homeBody(context),
      ),
    );
  }

  Widget _homeBody(BuildContext context){
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h,),
              _homeGreeting(),
              _homeFeaturedWorkoutTitle(context),
              _homeFeaturedWorkoutContentList(context),
              _homeWorkoutLevelTitle(context),
              _homeWorkoutLevelList(context),
              _homeWorkoutLevelContentSection(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _homeGreeting(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Text(
        "Morning, Messi 💪",
        style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 24.sp)
      ),
    );
  }

  Widget _homeFeaturedWorkoutTitle(BuildContext context){
    return Padding(
      padding: EdgeInsets.fromLTRB(4.w, 3.h, 4.w, 3.h),
      child: Text(
        "Featured Workout",
        style: GoogleFonts.urbanist(fontWeight: FontWeight.w600, fontSize: 18.sp, color: Colors.white),
      ),
    );
  }

  Widget _homeFeaturedWorkoutContentList(BuildContext context){
    return SizedBox(
      width: double.infinity,
      height: 30.h,
      child: ListView.builder(
        itemCount: DummyHelper.workouts.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index){
          return WorkoutContentItem(index: index, isHorizontal: true,);
        },
      ),
    );
  }

  Widget _homeWorkoutLevelTitle(BuildContext context){
    return Padding(
      padding: EdgeInsets.fromLTRB(4.w, 3.h, 4.w, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Workout Levels",
            style: GoogleFonts.urbanist(fontWeight: FontWeight.w600, fontSize: 18.sp, color: Colors.white),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRoutes.workoutLevelScreen),
            child: Text(
              "See All",
              style: GoogleFonts.urbanist(fontWeight: FontWeight.w600, fontSize: 17.sp, color: AppTheme.primaryColor),
            ),
          )
        ],
      ),
    );
  }

  Widget _homeWorkoutLevelList(BuildContext context){
    return WorkoutLevelItem(
      selectedLevel: _level,
    );
  }

  Widget _homeWorkoutLevelContentSection(BuildContext context){
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        children: _homeWorkoutLevelContentList(),
      ),
    );
  }

  List<Widget> _homeWorkoutLevelContentList(){
    List<Widget> list = <Widget>[];

    for(var workout in DummyHelper.workouts){
      list.add(WorkoutContentItem(index: DummyHelper.workouts.indexOf(workout), isHorizontal: false, level: _level,));
    }

    return list;
  }
}