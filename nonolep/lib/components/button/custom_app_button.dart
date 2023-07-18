import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nonolep/utils/app_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomAppButton extends StatelessWidget{
  const CustomAppButton({
    super.key,
    this.height,
    this.width,
    this.fontSize,
    this.iconSize,
    this.label,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.iconColor,
    this.radius,
    this.onTap,
    this.iconData,
    required this.loading,
    this.child,
  });
  final double? height;
  final double? width;
  final double? fontSize;
  final double? iconSize;
  final String? label;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? iconColor;
  final double? radius;
  final void Function()? onTap;
  final IconData? iconData;
  final bool loading;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    if(loading){
      return SizedBox(
        width: width ?? double.infinity,
        height: height ?? 4.75.h,
        child: ElevatedButton(
          onPressed: (){},
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppTheme.scaffoldColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius ?? 32),
                side: BorderSide(color: borderColor ?? AppTheme.primaryColor)
            ),
          ),
          child: LoadingAnimationWidget.prograssiveDots(
            color: borderColor ?? AppTheme.primaryColor,
            size: 3.vmax,
          ),
        ),
      );
    }else{
      if(child != null){
        return SizedBox(
          width: width ?? double.infinity,
          height: height ?? 4.75.h,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: backgroundColor ?? AppTheme.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius ?? 32),
                  side: BorderSide(color: borderColor ?? Colors.transparent)
              ),
            ),
            child: child,
          ),
        );
      }else{
        if(iconData == null){
          return SizedBox(
            width: width ?? double.infinity,
            height: height ?? 4.75.h,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: backgroundColor ?? AppTheme.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius ?? 32),
                    side: BorderSide(color: borderColor ?? Colors.transparent)
                ),
              ),
              child: Text(
                label!,
                style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: fontSize ?? 16.sp, color: textColor ?? Colors.white),
              ),
            ),
          );
        }else{
          if(label == null){
            return SizedBox(
              width: width ?? 30.w,
              height: height ?? 4.75.h,
              child: ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: backgroundColor ?? AppTheme.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius ?? 32),
                    side: BorderSide(color: borderColor ?? AppTheme.primaryColor),
                  ),
                ),
                child: Icon(iconData, color: iconColor ?? Colors.black,),
              ),
            );
          }else{
            return SizedBox(
              width: width ?? double.infinity,
              height: height ?? 4.75.h,
              child: ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: backgroundColor ?? AppTheme.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius ?? 32),
                    side: BorderSide(color: borderColor ?? AppTheme.primaryColor),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(iconData, color: iconColor ?? Colors.black, size: iconSize ?? 3.15.vmax,),
                    SizedBox(width: 2.w),
                    Text(
                      label!,
                      style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: fontSize ?? 16.sp, color: textColor ?? Colors.white),
                    )
                  ],
                ),
              ),
            );
          }
        }
      }
    }
  }
}