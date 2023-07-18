import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nonolep/components/custom_app_bar.dart';
import 'package:nonolep/models/notification_model.dart';
import 'package:nonolep/utils/app_theme.dart';
import 'package:nonolep/utils/constants/app_constant.dart';
import 'package:nonolep/utils/helpers/dummy_helper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sticky_headers/sticky_headers.dart';

class NotificationScreen extends StatelessWidget{
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.withArrowBackLogo(
          title: "Notification",
          actions: [
            GestureDetector(
              onTap: (){},
              child: Icon(Icons.pending_outlined, size: 3.5.vmax, color: Colors.white,),
            ),
            SizedBox(width: 2.45.w,),
          ]
      ),
      body: _notificationBody(context),
    );
  }

  Widget _notificationBody(BuildContext context){
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: _notificationItemList(context),
      ),
    );
  }

  Widget _notificationItemList(BuildContext context){
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: DummyHelper.uniqueNotifications.length,
      itemBuilder: (context, index){
        return StickyHeader(
          header: _notificationItemHeader(index),
          content: Wrap(
            children: _notificationItemContentList(index),
          ),
        );
      },
    );
  }

  Widget _notificationItemHeader(int index){
    return Container(
      width: double.infinity,
      color: AppTheme.scaffoldColor,
      padding: EdgeInsets.only(bottom: 1.h, top: 1.h),
      child: Text(
        DateFormat('MMMM d, yyyy').format(DummyHelper.uniqueNotifications[index].day),
        style: GoogleFonts.urbanist(fontWeight: FontWeight.w600, fontSize: 17.sp, color: Colors.white),
      ),
    );
  }

  List<Widget> _notificationItemContentList(int index){
    List<Widget> list = <Widget>[];
    List<NotificationModel> notifications = DummyHelper.notifications.where((e) => e.day == DummyHelper.uniqueNotifications[index].day).toList();

    for(var notification in notifications){
      list.add(_notificationItemContent(notification));
    }

    return list;
  }

  Widget _notificationItemContent(NotificationModel notification){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppTheme.onScaffoldColor
      ),
      margin: EdgeInsets.only(bottom: 2.h),
      child: ListTile(
        leading: CircleAvatar(
          radius: 3.vmax,
          backgroundColor: _notificationItemContentLeadingColor(notification.type),
          child: Center(
            child: Container(
              width: 4.w,
              height: 2.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4)
              ),
              child: Center(
                child: Icon(_notificationItemContentLeadingIcon(notification.type), color: _notificationItemContentLeadingColor(notification.type), size: 1.5.vmax,),
              ),
            ),
          ),
        ),
        title: Text(
          notification.title,
          style: GoogleFonts.urbanist(fontWeight: FontWeight.w600, fontSize: 18.sp, color: Colors.white),
        ),
        subtitle: Text(
          notification.message,
          style: GoogleFonts.urbanist(fontWeight: FontWeight.w400, fontSize: 16.sp, color: Colors.white),
        ),
      ),
    );
  }

  Color _notificationItemContentLeadingColor(String type){
    if(type == AppConstant.notifSuccess){
      return AppTheme.successColor;
    }else if(type == AppConstant.notifWorkout){
      return AppTheme.workoutColor;
    }else{
      return AppTheme.featureColor;
    }
  }

  IconData _notificationItemContentLeadingIcon(String type){
    if(type == AppConstant.notifSuccess){
      return Ionicons.checkmark;
    }else if(type == AppConstant.notifWorkout){
      return Ionicons.add;
    }else{
      return LineIcons.clock;
    }
  }
}