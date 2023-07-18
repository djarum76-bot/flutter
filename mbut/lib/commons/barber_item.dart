import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mbut/utils/app_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MbutItem extends StatelessWidget{
  const MbutItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        width: double.infinity,
        height: 15.h,
        margin: EdgeInsets.only(bottom: 2.h),
        padding: EdgeInsets.all(2.h),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(16)
                ),
              ),
            ),
            SizedBox(width: 2.w,),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Belle Curls',
                    style: GoogleFonts.urbanist(fontSize: 18.sp, fontWeight: FontWeight.w600),
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '0993 Novick Parwat',
                    style: GoogleFonts.urbanist(fontSize: 15.sp, color: const Color(0xFF7d7d7d)),
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(LineIcons.mapMarker, size: 4.w, color: AppTheme.primaryColor,),
                      SizedBox(width: 1.w,),
                      Text(
                        '1.2 km',
                        style: GoogleFonts.urbanist(fontSize: 15.sp),
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(width: 2.w,),
                      Icon(LineIcons.star, size: 4.w, color: AppTheme.primaryColor,),
                      SizedBox(width: 1.w,),
                      Text(
                        '4.8',
                        style: GoogleFonts.urbanist(fontSize: 15.sp),
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(width: 2.w,),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topCenter,
                child: GestureDetector(
                  onTap: (){},
                  child: const Icon(LineIcons.bookmark),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}