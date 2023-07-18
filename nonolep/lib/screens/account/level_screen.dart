import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nonolep/components/button/custom_app_button.dart';
import 'package:nonolep/components/custom_app_dialog.dart';
import 'package:nonolep/models/user_model.dart';
import 'package:nonolep/services/local/local_storage.dart';
import 'package:nonolep/utils/app_routes.dart';
import 'package:nonolep/utils/app_theme.dart';
import 'package:nonolep/utils/screen_argument.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LevelScreen extends StatefulWidget{
  const LevelScreen({super.key});

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  late LocalStorage _storage;
  late UserModel _user;
  late String _level;
  final List<String> _levels = <String>["Beginner", "Intermediate", "Advanced"];

  @override
  void initState() {
    _storage = LocalStorage.instance;
    _level = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _levelBody(context),
    );
  }

  Widget _levelBody(BuildContext context){
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 6.w,  vertical: 3.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _levelUpperSection(),
            _levelMainSection(),
            _levelSubmitButton(context)
          ],
        ),
      ),
    );
  }

  Widget _levelUpperSection(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Physical Activity Level?",
          style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 24.sp),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 1.5.h,),
        Text(
          "Choose your regular activity level. This will help us to personalize plans for you",
          style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17.sp),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget _levelMainSection(){
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 3.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _levelTypeButtonList(),
          ),
        ),
      ),
    );
  }

  List<Widget> _levelTypeButtonList(){
    List<Widget> list = <Widget>[];

    for(var level in _levels){
      list.add(_levelTypeButton(label: level));
    }

    return list;
  }

  Widget _levelTypeButton({required String label}){
    return Column(
      children: [
        CustomAppButton(
          height: 8.h,
          loading: false,
          backgroundColor: _level == label ? AppTheme.primaryColor : AppTheme.onScaffoldColor,
          borderColor: _level == label ? Colors.transparent : AppTheme.greyBorderColor,
          radius: 12,
          onTap: (){
            setState(() {
              _level = label;
            });
          },
          label: label,
        ),
        SizedBox(height: 1.75.h,)
      ],
    );
  }

  Widget _levelSubmitButton(BuildContext  context){
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
              if(_level == ""){
                CustomAppDialog.errorDialog(context, message: "You must choose ur level");
              }else{
                _user = await _storage.user;
                _user.level = _level;

                await _user.save().then((value){
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.fillProfileScreen,
                      arguments: ScreenArgument<String>(_user.email!),
                      (route) => false
                  );
                });
              }
            },
          ),
        )
      ],
    );
  }
}