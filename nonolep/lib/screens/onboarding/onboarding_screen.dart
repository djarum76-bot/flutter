import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nonolep/components/button/custom_app_button.dart';
import 'package:nonolep/services/local/local_storage.dart';
import 'package:nonolep/utils/app_routes.dart';
import 'package:nonolep/utils/app_theme.dart';
import 'package:nonolep/utils/constants/local_constant.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OnboardingScreen extends StatefulWidget{
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late LocalStorage _storage;
  late PageController _pageController;

  final List<dynamic> _itemList = [
    'assets/images/onboarding-1.jpg',
    'assets/images/onboarding-2.jpg',
    'assets/images/onboarding-3.jpg',
  ];

  final List<String> _textList = [
    "Find the right workout for what you need",
    "Make suitable workouts and great results",
    "Let's do a workout and live healthy with us",
  ];

  @override
  void initState() {
    _storage = LocalStorage.instance;
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _onboardingBody(),
    );
  }

  Widget _onboardingBody(){
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: _onboardingCarouselList(),
      ),
    );
  }

  Widget _onboardingCarouselList(){
    return PageView(
      controller: _pageController,
      children: [
        _onboardingCarouselItem(index: 0),
        _onboardingCarouselItem(index: 1),
        _onboardingCarouselItem(index: 2),
      ],
    );
  }

  Widget _onboardingCarouselItem({required int index}){
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(_itemList[index]),
          fit: BoxFit.cover
        )
      ),
      width: double.infinity,
      height: double.infinity,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: 40.h,
          color: AppTheme.scaffoldColor,
          padding: EdgeInsets.symmetric(horizontal: 6.w,  vertical: 3.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _textList[index],
                style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 26.sp),
                textAlign: TextAlign.center,
              ),
              DotsIndicator(
                dotsCount: 3,
                position: index,
                decorator: DotsDecorator(
                  color: AppTheme.dotColor, // Inactive color
                  activeColor: AppTheme.primaryColor,
                  activeSize: const Size(30.0, 9.0),
                  activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
              CustomAppButton(
                height: 6.h,
                loading: false,
                label: "Next",
                onTap: ()async{
                  if(index != 2){
                    _pageController.animateToPage(index + 1, duration: const Duration(milliseconds: 500), curve: Curves.ease);
                  }else{
                    await _storage.setData<bool>(LocalConstant.skipIntro, true).then((value){
                      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.authenticationScreen, (route) => false);
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}