import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nonolep/components/button/custom_app_button.dart';
import 'package:nonolep/models/user_model.dart';
import 'package:nonolep/services/local/local_storage.dart';
import 'package:nonolep/utils/app_routes.dart';
import 'package:nonolep/utils/app_theme.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AgeScreen extends StatefulWidget{
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  late LocalStorage _storage;
  late UserModel _user;
  late int _age;

  @override
  void initState() {
    _storage = LocalStorage.instance;
    _age = 20;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ageBody(context),
    );
  }

  Widget _ageBody(BuildContext context){
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 6.w,  vertical: 3.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _ageUpperSection(),
            _ageMainSection(),
            _ageSubmitButton(context)
          ],
        ),
      ),
    );
  }

  Widget _ageUpperSection(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "How Old Are You?",
          style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 24.sp),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 1.5.h,),
        Text(
          "Age in years. This will help us to personalize an exercise program plan that suits you",
          style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17.sp),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget _ageMainSection(){
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: NumberPicker(
            minValue: 10,
            maxValue: 100,
            value: _age,
            onChanged: (val){
              setState(() {
                _age = val;
              });
            },
            decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppTheme.primaryColor, width: 1.w),
                  bottom: BorderSide(color: AppTheme.primaryColor, width: 1.w),
                )
            ),
            textStyle: GoogleFonts.urbanist(fontWeight: FontWeight.w600, fontSize: 30.sp, color: Colors.white),
            selectedTextStyle: GoogleFonts.urbanist(fontWeight: FontWeight.w600, fontSize: 31.sp, color: AppTheme.primaryColor),
            itemWidth: 25.w,
            itemHeight: 10.h,
            itemCount: 7,
          ),
        ),
      ),
    );
  }

  Widget _ageSubmitButton(BuildContext  context){
    return Row(
      children: [
        Expanded(
          child: CustomAppButton(
            height: 6.h,
            loading: false,
            label: "Back",
            backgroundColor: AppTheme.onScaffoldColor,
            onTap: () => Navigator.pop(context),
          ),
        ),
        SizedBox(width: 3.w,),
        Expanded(
          child: CustomAppButton(
            height: 6.h,
            loading: false,
            label: "Continue",
            onTap: ()async{
              _user = await _storage.user;
              _user.age = _age;

              await _user.save().then((value){
                Navigator.pushNamed(context, AppRoutes.weightScreen);
              });
            },
          ),
        )
      ],
    );
  }
}