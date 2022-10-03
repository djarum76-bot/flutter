import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:notif/app/routes/app_pages.dart';

class HomeController extends GetxController {
  void sendNotification(){
    AwesomeNotifications().isNotificationAllowed().then((isAllowed){
      if(!isAllowed){
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 1,
            channelKey: 'test_channel',
            title: 'Notifikasi',
            body: ' Ini Body nya'
        )
    );

    AwesomeNotifications().actionStream.listen((event) {
      Get.toNamed(Routes.NOTIF);
    });
  }
}
