import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nonolep/components/button/custom_app_button.dart';
import 'package:nonolep/models/user_model.dart';
import 'package:nonolep/services/local/local_storage.dart';
import 'package:nonolep/utils/app_routes.dart';
import 'package:nonolep/utils/app_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GoalScreen extends StatefulWidget{
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  late LocalStorage _storage;
  late UserModel _user;
  late List<String> _selectedGoal;
  final List<String> _goals = <String>[
    "Get Fitter",
    "Gain Weight",
    "Lose Weight",
    "Building Muscles",
    "Improving Endurance",
    "Others",
  ];

  @override
  void initState() {
    _storage = LocalStorage.instance;
    _selectedGoal = <String>[];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _goalBody(context),
    );
  }

  Widget _goalBody(BuildContext context){
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 6.w,  vertical: 3.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _goalUpperSection(),
            _goalMainSection(),
            _goalSubmitButton(context)
          ],
        ),
      ),
    );
  }

  Widget _goalUpperSection(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "What is Your Goal?",
          style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 24.sp),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 1.5.h,),
        Text(
          "You can choose more than one. Don't worry, you can always change it later",
          style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17.sp),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget _goalMainSection(){
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 3.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _goalTypeButtonList(),
          ),
        ),
      ),
    );
  }

  List<Widget> _goalTypeButtonList(){
    List<Widget> list = <Widget>[];

    for(var goal in _goals){
      list.add(_goalTypeButton(label: goal));
    }

    return list;
  }

  Widget _goalTypeButton({required String label}){
    return Column(
      children: [
        CustomAppButton(
          height: 8.h,
          loading: false,
          backgroundColor: AppTheme.onScaffoldColor,
          borderColor: _selectedGoal.contains(label) ? AppTheme.primaryColor : Colors.transparent,
          radius: 12,
          onTap: (){
            if(_selectedGoal.contains(label)){
              setState(() {
                _selectedGoal.remove(label);
              });
            }else{
              setState(() {
                _selectedGoal.add(label);
              });
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                label,
                style: GoogleFonts.urbanist(fontWeight: FontWeight.w500, fontSize: 17.sp, color: Colors.white),
              ),
              Container(
                width: 4.w,
                height: 2.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppTheme.primaryColor),
                  color: _selectedGoal.contains(label) ? AppTheme.primaryColor : Colors.transparent
                ),
                child: Center(
                  child: Icon(Ionicons.checkmark, size: 1.5.vmax, color: _selectedGoal.contains(label) ? Colors.white : Colors.transparent),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 1.75.h,)
      ],
    );
  }

  Widget _goalSubmitButton(BuildContext  context){
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
              _user.goals = _selectedGoal;

              await _user.save().then((value){
                Navigator.pushNamed(context, AppRoutes.levelScreen);
              });
            },
          ),
        )
      ],
    );
  }
}