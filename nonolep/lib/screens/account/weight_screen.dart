import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nonolep/components/button/custom_app_button.dart';
import 'package:nonolep/models/user_model.dart';
import 'package:nonolep/services/local/local_storage.dart';
import 'package:nonolep/utils/app_routes.dart';
import 'package:nonolep/utils/app_theme.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WeightScreen extends StatefulWidget{
  const WeightScreen({super.key});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  late LocalStorage _storage;
  late UserModel _user;
  late int _weight;

  @override
  void initState() {
    _storage = LocalStorage.instance;
    _weight = 40;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _weightBody(context),
    );
  }

  Widget _weightBody(BuildContext context){
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _weightUpperSection(),
            _weightMainSection(),
            _weightSubmitButton(context)
          ],
        ),
      ),
    );
  }

  Widget _weightUpperSection(){
    return Padding(
      padding: EdgeInsets.fromLTRB(6.w, 3.h, 6.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "What is Your Weight?",
            style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 24.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 1.5.h,),
          Text(
            "Weight in kg. Don't worry, you can always change it later",
            style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17.sp),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Widget _weightMainSection(){
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: NumberPicker(
            minValue: 30,
            maxValue: 200,
            value: _weight,
            axis: Axis.horizontal,
            onChanged: (val){
              setState(() {
                _weight = val;
              });
            },
            decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppTheme.primaryColor, width: 1.w),
                )
            ),
            textStyle: GoogleFonts.urbanist(fontWeight: FontWeight.w600, fontSize: 25.sp, color: Colors.white),
            selectedTextStyle: GoogleFonts.urbanist(fontWeight: FontWeight.w600, fontSize: 26.sp, color: AppTheme.primaryColor),
            itemWidth: 19.2.w,
            itemHeight: 10.h,
            itemCount: 5,
          ),
        ),
      ),
    );
  }

  Widget _weightSubmitButton(BuildContext  context){
    return Padding(
      padding: EdgeInsets.fromLTRB(6.w, 0, 6.w, 3.h),
      child: Row(
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
                _user.weight = _weight;

                await _user.save().then((value){
                  Navigator.pushNamed(context, AppRoutes.heightScreen);
                });
              },
            ),
          )
        ],
      ),
    );
  }
}