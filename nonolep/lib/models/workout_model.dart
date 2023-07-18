import 'package:nonolep/models/workout_detail_model.dart';

class WorkoutModel{
  final String title;
  final String image;
  final int minute;
  final List<WorkoutActivityModel> workoutActivity;

  WorkoutModel({required this.title, required this.image, required this.minute, required this.workoutActivity});
}