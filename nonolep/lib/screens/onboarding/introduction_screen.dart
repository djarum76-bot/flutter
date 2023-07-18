import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nonolep/utils/app_routes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class IntroductionScreen extends StatefulWidget{
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), (){
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.onboardingScreen, (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _introductionBody(),
    );
  }

  Widget _introductionBody(){
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/introduction.jpg"),
            fit: BoxFit.cover
          )
        ),
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Welcome to 💪",
              style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 28.sp)
            ),
            SizedBox(height: 1.h,),
            Text(
              "Nonolep",
              style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 34.sp)
            ),
            SizedBox(height: 2.h,),
            Text(
              "The best fitness app for nolep people like u who read this",
              style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17.sp)
            )
          ],
        )
      ),
    );
  }
}