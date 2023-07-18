import 'package:flutter/material.dart';
import 'package:nonolep/components/custom_app_bar.dart';
import 'package:nonolep/components/workout_content_item.dart';
import 'package:nonolep/components/workout_level_item.dart';
import 'package:nonolep/utils/helpers/dummy_helper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WorkoutLevelScreen extends StatefulWidget{
  const WorkoutLevelScreen({super.key});

  @override
  State<WorkoutLevelScreen> createState() => _WorkoutLevelScreenState();
}

class _WorkoutLevelScreenState extends State<WorkoutLevelScreen> {
  late String _level;

  @override
  void initState() {
    _level = DummyHelper.levels[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.withArrowBackLogo(
        title: "Workout Levels",
        actions: [
          GestureDetector(
            onTap: (){},
            child: Icon(Icons.pending_outlined, size: 3.5.vmax, color: Colors.white,),
          ),
          SizedBox(width: 2.45.w,),
        ]
      ),
      body: _workoutLevelBody(context),
    );
  }

  Widget _workoutLevelBody(BuildContext context){
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            _workoutLevelList(context),
            _workoutLevelContentSection(context)
          ],
        ),
      ),
    );
  }

  Widget _workoutLevelList(BuildContext context){
    return WorkoutLevelItem(
      selectedLevel: _level,
    );
  }

  Widget _workoutLevelContentSection(BuildContext context){
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ListView.builder(
          itemCount: DummyHelper.workouts.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index){
            return WorkoutContentItem(index: index, isHorizontal: false, level: _level,);
          },
        ),
      ),
    );
  }
}