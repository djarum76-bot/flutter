import 'package:flutter/material.dart';
import 'package:nonolep/components/button/custom_app_button.dart';
import 'package:nonolep/utils/app_theme.dart';
import 'package:nonolep/utils/helpers/dummy_helper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WorkoutLevelItem extends StatefulWidget{
  final String selectedLevel;

  const WorkoutLevelItem({super.key, required this.selectedLevel});

  @override
  State<WorkoutLevelItem> createState() => _WorkoutLevelItemState();
}

class _WorkoutLevelItemState extends State<WorkoutLevelItem> {
  late String _selectedLevel;

  @override
  void initState() {
    _selectedLevel = widget.selectedLevel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(4.w, 3.h, 4.w, 2.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _homeWorkoutLevelButton(),
      ),
    );
  }

  List<Widget> _homeWorkoutLevelButton(){
    List<Widget> list = <Widget>[];

    for(var level in DummyHelper.levels){
      list.add(
          Expanded(
            child: CustomAppButton(
                height: 4.5.h,
                loading: false,
                backgroundColor: _selectedLevel == level ? AppTheme.primaryColor : AppTheme.scaffoldColor,
                borderColor: _selectedLevel == level ? Colors.transparent : AppTheme.primaryColor,
                label: level,
                textColor: _selectedLevel == level ? Colors.white : AppTheme.primaryColor,
                onTap: (){
                  setState(() {
                    _selectedLevel = level;
                  });
                },
                fontSize: 15.sp
            ),
          )
      );

      if(DummyHelper.levels.indexOf(level) != DummyHelper.levels.length - 1){
        list.add(SizedBox(width: 3.w,));
      }
    }

    return list;
  }
}