import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nonolep/components/button/custom_app_button.dart';
import 'package:nonolep/components/custom_app_dialog.dart';
import 'package:nonolep/models/user_model.dart';
import 'package:nonolep/services/local/local_storage.dart';
import 'package:nonolep/utils/app_routes.dart';
import 'package:nonolep/utils/app_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GenderScreen extends StatefulWidget{
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  late LocalStorage _storage;
  late UserModel _user;
  late String _gender;

  @override
  void initState() {
    _storage = LocalStorage.instance;
    _gender = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>  CustomAppDialog.exitApplication(context),
      child: Scaffold(
        body: _genderBody(context),
      ),
    );
  }

  Widget _genderBody(BuildContext context){
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 6.w,  vertical: 3.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _genderUpperSection(),
            _genderMainSection(),
            _genderSubmitButton(context)
          ],
        ),
      ),
    );
  }

  Widget _genderUpperSection(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Tell Us About Yourself",
          style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 24.sp),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 1.5.h,),
        Text(
          "To give you a better experience and results we need to know your gender",
          style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17.sp),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget _genderMainSection(){
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _genderSelectionButton(icon: LineIcons.male, label: "Male"),
            SizedBox(height: 3.h,),
            _genderSelectionButton(icon: LineIcons.female, label: "Female"),
          ],
        ),
      ),
    );
  }

  Widget _genderSelectionButton({required IconData icon, required String label}){
    return GestureDetector(
      onTap: (){
        setState(() {
          _gender = label;
        });
      },
      child: CircleAvatar(
        backgroundColor: _gender == label ? AppTheme.primaryColor : AppTheme.onScaffoldColor,
        radius: 12.vmax,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 10.vmax,),
            SizedBox(height: 1.h,),
            Text(
              label,
              style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 22.sp),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  Widget _genderSubmitButton(BuildContext  context){
    return CustomAppButton(
      height: 6.h,
      loading: false,
      label: "Continue",
      onTap: ()async{
        if(_gender == ""){
          CustomAppDialog.errorDialog(context, message: "You must choose ur gender");
        }else{
          _user = await _storage.user;
          _user.gender = _gender;

          await _user.save().then((value){
            Navigator.pushNamed(context, AppRoutes.ageScreen);
          });
        }
      },
    );
  }
}