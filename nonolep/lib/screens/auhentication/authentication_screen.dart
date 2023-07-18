import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nonolep/components/button/custom_app_button.dart';
import 'package:nonolep/components/custom_app_dialog.dart';
import 'package:nonolep/utils/app_routes.dart';
import 'package:nonolep/utils/app_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AuthenticationScreen extends StatelessWidget{
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>  CustomAppDialog.exitApplication(context),
      child: Scaffold(
        body: _authenticationBody(context),
      ),
    );
  }

  Widget _authenticationBody(BuildContext context){
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 6.w,  vertical: 3.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 5.h,),
            _authenticationText(),
            _authenticationSocialMediaButtonList(),
            _authenticationSeparator(),
            _authenticationSignInButton(context),
            _authenticationBottomSection(context)
          ],
        ),
      ),
    );
  }

  Widget _authenticationText(){
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        "Let's you in",
        style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 29.sp),
      ),
    );
  }

  Widget _authenticationSocialMediaButtonList(){
    return Column(
      children: [
        _authenticationSocialMediaButton(icon: LineIcons.facebook, label: "Facebook", color: Colors.blue),
        SizedBox(height: 1.75.h,),
        _authenticationSocialMediaButton(icon: LineIcons.googleLogo, label: "Google", color: Colors.red),
        SizedBox(height: 1.75.h,),
        _authenticationSocialMediaButton(icon: LineIcons.apple, label: "Apple", color: Colors.white),
      ],
    );
  }

  Widget _authenticationSocialMediaButton({required IconData icon, required String label, required Color color}){
    return CustomAppButton(
      height: 6.5.h,
      loading: false,
      label: "Continue with $label",
      iconData: icon,
      iconColor: color,
      backgroundColor: AppTheme.onScaffoldColor,
      borderColor: AppTheme.greyBorderColor,
      radius: 12,
      onTap: (){},
    );
  }

  Widget _authenticationSeparator(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 0.1.h,
          width: 37.5.w,
          color: AppTheme.separatorLineColor,
        ),
        Text(
          "or",
          style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 16.sp, color: Colors.white),
        ),
        Container(
          height: 0.1.h,
          width: 37.5.w,
          color: AppTheme.separatorLineColor,
        )
      ],
    );
  }

  Widget _authenticationSignInButton(BuildContext context){
    return CustomAppButton(
      height: 6.h,
      loading: false,
      label: "Sign in with password",
      onTap: () => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginScreen, (route) => false),
    );
  }

  Widget _authenticationBottomSection(BuildContext context){
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: "Don't have an account?",
          style: GoogleFonts.urbanist(fontWeight: FontWeight.w400, fontSize: 16.sp, color: AppTheme.greyTextColor),
          children: [
            TextSpan(
                text: '  Sign up',
                style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600, fontSize: 16.sp, color: AppTheme.primaryColor),
                recognizer: TapGestureRecognizer()..onTap = (){
                  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.registerScreen, (route) => false);
                }
            )
          ]
      ),
    );
  }
}