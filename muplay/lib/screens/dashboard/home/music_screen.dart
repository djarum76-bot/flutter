import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:muplay/utils/app_theme.dart';
import 'package:muplay/utils/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MusicScreen extends StatelessWidget{
  const MusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _musicBody(context),
    );
  }

  Widget _musicBody(BuildContext context){
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
        child: Column(
          children: [
            _musicBack(context),
            _musicData(context)
          ],
        ),
      ),
    );
  }

  Widget _musicBack(BuildContext context){
    return SizedBox(
      width: double.infinity,
      height: 5.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Ionicons.arrow_back, color: Colors.black, size: 3.h,),
          )
        ],
      ),
    );
  }

  Widget _musicData(BuildContext context){
    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(top: 2.h),
        child: ListView(
          children: [
            _musicDataImage(),
            SizedBox(height: 3.h,),
            _musicDataTitleArtist(),
            SizedBox(height: 2.h,),
            const Divider(),
            SizedBox(height: 2.h,),
            _musicDataProgressBar(context),
            SizedBox(height: 3.h,),
            _musicDataAction(context),
            SizedBox(height: 2.h,),
            const Divider(),
            SizedBox(height: 2.h,),
            _musicDataLyric()
          ],
        ),
      ),
    );
  }

  Widget _musicDataImage(){
    return Container(
      width: double.infinity,
      height: 40.h,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(20)
      ),
    );
  }

  Widget _musicDataTitleArtist(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Stay This Way',
          style: GoogleFonts.urbanist(color: const Color(0xFF212121), fontWeight: FontWeight.w700, fontSize: 21.sp),
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 1.h,),
        Text(
          'Fromis_9',
          style: GoogleFonts.urbanist(color: const Color(0xFF212121), fontWeight: FontWeight.w500, fontSize: 17.sp),
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }

  Widget _musicDataProgressBar(BuildContext context){
    return ProgressBar(
      progress: const Duration(seconds: 60),
      buffered: const Duration(seconds: 90),
      total: const Duration(seconds: 180),
      progressBarColor: AppTheme.primaryColor,
      thumbColor: AppTheme.primaryColor,
      onSeek: (duration){},
      timeLabelTextStyle: GoogleFonts.urbanist(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w600),
    );
  }

  Widget _musicDataAction(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _musicDataActionButton(context: context, onTap: (){}, icon: Ionicons.play_skip_back),
        _musicDataPlayPauseButton(context, true),
        _musicDataActionButton(context: context, onTap: (){}, icon: Ionicons.play_skip_forward),
      ],
    );
  }

  Widget _musicDataPlayPauseButton(BuildContext context, bool isPlay){
    return GestureDetector(
      onTap: (){},
      child: CircleAvatar(
        backgroundColor: isPlay ? const Color(0xFFff8e2c) : AppTheme.scaffoldColor,
        radius: 4.h,
        child: Center(
          child: Icon(isPlay ? LineIcons.play : Ionicons.pause, color: isPlay ? Colors.white : AppTheme.primaryColor, size: 5.h,),
        ),
      ),
    );
  }

  Widget _musicDataActionButton({required BuildContext context, required void Function()? onTap, required IconData icon}){
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, color: Colors.black, size: 5.h,),
    );
  }

  Widget _musicDataLyric(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lyric',
          style: GoogleFonts.urbanist(color: const Color(0xFF212121), fontWeight: FontWeight.w700, fontSize: 19.sp),
        ),
        SizedBox(height: 3.h,),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(2.h),
          decoration: BoxDecoration(
            color: const Color(0xFFfff3e8),
            borderRadius: BorderRadius.circular(20)
          ),
          child: Text(
            Constants.lyric,
            style: GoogleFonts.urbanist(color: const Color(0xFF212121), fontWeight: FontWeight.w700, fontSize: 19.sp),
          ),
        )
      ],
    );
  }
}