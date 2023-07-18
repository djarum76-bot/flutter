import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nonolep/components/custom_app_bar.dart';
import 'package:nonolep/components/workout_content_item.dart';
import 'package:nonolep/utils/helpers/dummy_helper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BookmarkScreen extends StatelessWidget{
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.withArrowBackLogo(
          title: "My Bookmark",
          actions: [
            GestureDetector(
              onTap: (){},
              child: Icon(Ionicons.newspaper_outline, size: 3.5.vmax, color: Colors.white,),
            ),
            SizedBox(width: 2.45.w,),
          ]
      ),
      body: _bookmarkBody(context),
    );
  }

  Widget _bookmarkBody(BuildContext context){
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 2.h,
            crossAxisSpacing: 1.5.h,
            childAspectRatio: 0.85
          ),
          itemCount: DummyHelper.workouts.length,
          itemBuilder: (context, index) {
            return WorkoutContentItem(isHorizontal: true, isGrid: true, index: index,);
          },
        ),
      ),
    );
  }
}