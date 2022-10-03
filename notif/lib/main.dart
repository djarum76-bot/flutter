import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'test_channel',
            channelName: 'Test Channel Notification',
            channelDescription: 'This is channel for notification testing'
        )
      ]
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
