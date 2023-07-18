import 'package:darq/darq.dart';
import 'package:nonolep/models/notification_model.dart';
import 'package:nonolep/models/workout_detail_model.dart';
import 'package:nonolep/models/workout_model.dart';
import 'package:nonolep/utils/constants/app_constant.dart';

class DummyHelper{
  static List<WorkoutModel> workouts = <WorkoutModel>[
    WorkoutModel(title: "Full Body Stretching", image: "assets/images/stretch.jpg", minute: 5, workoutActivity: workoutDetail),
    WorkoutModel(title: "Abdominal Exercise", image: "assets/images/abdominal.jpg", minute: 10, workoutActivity: workoutDetail),
    WorkoutModel(title: "Squat Movement Exercise", image: "assets/images/squat.jpg", minute: 15, workoutActivity: workoutDetail),
    WorkoutModel(title: "Yoga Movement Exercise", image: "assets/images/yoga.jpg", minute: 20, workoutActivity: workoutDetail),
  ];

  static List<WorkoutActivityModel> workoutDetail = <WorkoutActivityModel>[
    WorkoutActivityModel(title: "Butterfly Stretch", image: "assets/images/yoga-1.jpg", duration: 20),
    WorkoutActivityModel(title: "Malasana/Yogi Squat", image: "assets/images/yoga-2.jpg", duration: 30),
    WorkoutActivityModel(title: "Happy Baby Pose", image: "assets/images/yoga-3.jpg", duration: 40),
    WorkoutActivityModel(title: "Reclined Bound Angle Pose", image: "assets/images/yoga-4.jpg", duration: 50),
    WorkoutActivityModel(title: "Frog Pose", image: "assets/images/yoga-5.jpg", duration: 60),
    WorkoutActivityModel(title: "Supine Figure Four", image: "assets/images/yoga-6.jpg", duration: 30),
    WorkoutActivityModel(title: "Half Pigeon", image: "assets/images/yoga-7.jpg", duration: 20),
    WorkoutActivityModel(title: "Double Pigeon", image: "assets/images/yoga-8.jpg", duration: 40),
    WorkoutActivityModel(title: "Low Lunge", image: "assets/images/yoga-9.jpg", duration: 30),
    WorkoutActivityModel(title: "Crescent Lunge", image: "assets/images/yoga-10.jpg", duration: 30),
    WorkoutActivityModel(title: "Camel Pose", image: "assets/images/yoga-11.jpg", duration: 20),
    WorkoutActivityModel(title: "Dancer’s Pose", image: "assets/images/yoga-12.jpg", duration: 60),
    WorkoutActivityModel(title: "Supported Back Bend", image: "assets/images/yoga-13.jpg", duration: 60),
    WorkoutActivityModel(title: "Supported Bridge", image: "assets/images/yoga-14.jpg", duration: 30),
    WorkoutActivityModel(title: "Hip Pry", image: "assets/images/yoga-15.jpg", duration: 50),
    WorkoutActivityModel(title: "Hero Pose With Block", image: "assets/images/yoga-16.jpg", duration: 50),
  ];

  static List<String> levels = <String>["Beginner", "Intermediate", "Advanced"];

  static List<NotificationModel> notifications = <NotificationModel>[
    NotificationModel(type: AppConstant.notifSuccess, day: DateTime(2023, 7, 9), message: "You've been exercising for 2 hours", title: "Congratulations"),
    NotificationModel(type: AppConstant.notifWorkout, day: DateTime(2023, 7, 9), message: "Check now and practice", title: "New Workout is Available!"),
    NotificationModel(type: AppConstant.notifFeature, day: DateTime(2023, 7, 8), message: "You can now set exercise reminder", title: "New Features are Available"),
    NotificationModel(type: AppConstant.notifWorkout, day: DateTime(2023, 7, 3), message: "YouCheck now and practice", title: "New Workout is Available!"),
    NotificationModel(type: AppConstant.notifSuccess, day: DateTime(2023, 7, 2), message: "You've been exercising for 1 hours", title: "Congratulations"),
  ];

  static List<NotificationModel> uniqueNotifications = notifications.distinct((n) => n.day).toList();

  static List<String> history = <String>[
    "Abdominal",
    "Full Body",
    "Yoga Exercise",
    "Squat Movement",
    "Dumbbell",
    "Leg Exercise",
  ];
}