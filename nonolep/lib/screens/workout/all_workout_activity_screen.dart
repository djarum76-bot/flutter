import 'package:flutter/material.dart';
import 'package:nonolep/components/button/start_button_for_workout.dart';
import 'package:nonolep/components/custom_app_bar.dart';
import 'package:nonolep/components/workout_activity_item.dart';
import 'package:nonolep/models/workout_detail_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AllWorkoutActivityScreen extends StatelessWidget{
  const AllWorkoutActivityScreen({super.key, required this.workoutActivityModel});
  final List<WorkoutActivityModel> workoutActivityModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.withArrowBackLogo(title: "Workout Activity"),
      body: _allWorkoutActivityBody(context),
    );
  }
  
  Widget _allWorkoutActivityBody(BuildContext context){
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            _allWorkoutActivityList(context),
            StartButtonForWorkout(workoutActivityModel: workoutActivityModel)
          ],
        ),
      ),
    );
  }

  Widget _allWorkoutActivityList(BuildContext context){
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: ListView.builder(
          itemCount: workoutActivityModel.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index){
            return WorkoutActivityItem(workoutActivityModel: workoutActivityModel[index]);
          },
        ),
      ),
    );
  }
}