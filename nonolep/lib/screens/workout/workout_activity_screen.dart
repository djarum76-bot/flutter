import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nonolep/components/button/custom_app_button.dart';
import 'package:nonolep/components/custom_app_dialog.dart';
import 'package:nonolep/models/workout_detail_model.dart';
import 'package:nonolep/utils/app_routes.dart';
import 'package:nonolep/utils/app_theme.dart';
import 'package:nonolep/utils/screen_argument.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WorkoutActivityScreen extends StatefulWidget{
  const WorkoutActivityScreen({super.key, required this.workoutActivityModel});
  final List<WorkoutActivityModel> workoutActivityModel;

  @override
  State<WorkoutActivityScreen> createState() => _WorkoutActivityScreenState();
}

class _WorkoutActivityScreenState extends State<WorkoutActivityScreen> {
  late CountDownController _countDownController;
  bool _isReady = false;
  bool _isRest = false;
  String _label = "PAUSE";
  int _duration = 10;

  int _index = 0;

  @override
  void initState() {
    _countDownController = CountDownController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        if(_isRest){
          setState(() {
            _index--;
            _isRest = false;
          });
        }else{
          _countDownController.pause();
          CustomAppDialog.exitActivity(context, countDownController: _countDownController);
        }

        return Future.value(false);
      },
      child: Scaffold(
        body: _workoutActivityBody(context),
      ),
    );
  }

  Widget _workoutActivityBody(BuildContext context){
    if(_isReady){
      if(_isRest){
        return _workoutActivityRestSection(context);
      }else{
        return _workoutActivityReadySection(context);
      }
    }else{
      return _workoutActivityNotReadySection(context);
    }
  }

  Widget _workoutActivityReadySection(BuildContext context){
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            _workoutActivityReadyUpperSection(context),
            _workoutActivityReadyBottomSection(context)
          ],
        ),
      ),
    );
  }

  Widget _workoutActivityReadyUpperSection(BuildContext context){
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(widget.workoutActivityModel[_index].image),
                      fit: BoxFit.cover
                  )
              ),
            ),
            Container(
              width: double.infinity,
              height: 30.h,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black38,
                        Colors.transparent,
                      ]
                  )
              ),
              child: _workoutActivityBackButton(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _workoutActivityReadyBottomSection(BuildContext context){
    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.workoutActivityModel[_index].title,
              style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 22.sp),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _workoutActivityCircularTimer(context),
                _workoutActivityReadyPauseButton(),
              ],
            ),
            _workoutActivityReadyActionButtonList()
          ],
        ),
      ),
    );
  }

  Widget _workoutActivityReadyPauseButton(){
    return CustomAppButton(
      loading: false,
      label: _label,
      height: 5.h,
      width: 25.w,
      backgroundColor: AppTheme.primaryColor,
      onTap: (){
        if(_countDownController.isStarted){
          if(_countDownController.isPaused){
            _countDownController.resume();
            setState(() {
              _label = "PAUSE";
            });
          }else{
            _countDownController.pause();
            setState(() {
              _label = "START";
            });
          }
        }
      },
    );
  }

  Widget _workoutActivityReadyActionButtonList(){
    return Row(
      children: [
        _workoutActivityReadyActionButton(isPrevious: true),
        SizedBox(width: 3.w,),
        _workoutActivityReadyActionButton(isPrevious: false),
      ],
    );
  }

  Widget _workoutActivityReadyActionButton({required bool isPrevious}){
    if(isPrevious){
      if(_index == 0){
        return const Expanded(
          child: SizedBox(),
        );
      }else{
        return Expanded(
          child: CustomAppButton(
            loading: false,
            height: 6.h,
            backgroundColor: AppTheme.ringTimerColor,
            borderColor: AppTheme.ringTimerColor,
            onTap: (){
              setState(() {
                _index--;
                _duration = widget.workoutActivityModel[_index].duration;
              });
              _countDownController.restart(duration: _duration);
            },
            label: "⮜ Previous",
          ),
        );
      }
    }else{
      if(_index == widget.workoutActivityModel.length - 1){
        return const Expanded(
          child: SizedBox(),
        );
      }else{
        return Expanded(
          child: CustomAppButton(
            loading: false,
            height: 6.h,
            backgroundColor: AppTheme.ringTimerColor,
            borderColor: AppTheme.ringTimerColor,
            onTap: (){
              setState(() {
                _index++;
                _isRest = true;
              });
            },
            label: "Next ➤",
          ),
        );
      }
    }
  }

  Widget _workoutActivityRestSection(BuildContext context){
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _workoutActivityBackButton(context),
            _workoutActivityRestMainSection(),
            _workoutActivityRestButton()
          ],
        ),
      ),
    );
  }

  Widget _workoutActivityRestMainSection(){
    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "TAKE A REST",
              style: GoogleFonts.urbanist(color: AppTheme.primaryColor, fontWeight: FontWeight.w700, fontSize: 26.sp),
            ),
            TimerCountdown(
              format: CountDownTimerFormat.minutesSeconds,
              endTime: DateTime.now().add(const Duration(minutes: 00, seconds: 10,)),
              onEnd: (){
                setState(() {
                  _duration = widget.workoutActivityModel[_index].duration;
                  _isRest = false;
                });
                _countDownController.restart(duration: _duration);
              },
              enableDescriptions: false,
              timeTextStyle: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 26.sp),
              colonsTextStyle: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 26.sp),
            ),
            Container(
              height: 0.1.h,
              width: double.infinity,
              color: AppTheme.separatorLineColor,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Next Movement (${_index + 1}/${widget.workoutActivityModel.length})",
                style: GoogleFonts.urbanist(fontWeight: FontWeight.w500, fontSize: 17.sp, color: Colors.white),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.workoutActivityModel[_index].title,
                style: GoogleFonts.urbanist(fontWeight: FontWeight.w600, fontSize: 18.sp, color: Colors.white),
              ),
            ),
            Container(
              width: double.infinity,
              height: 45.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                image: DecorationImage(
                  image: AssetImage(widget.workoutActivityModel[_index].image),
                  fit: BoxFit.cover
                )
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _workoutActivityRestButton(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: CustomAppButton(
        height: 6.h,
        loading: false,
        label: "Skip Rest",
        onTap: (){
          setState(() {
            _duration = widget.workoutActivityModel[_index].duration;
            _isRest = false;
          });
          _countDownController.restart(duration: _duration);
        },
      ),
    );
  }

  Widget _workoutActivityNotReadySection(BuildContext context){
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _workoutActivityBackButton(context),
            _workoutActivityNotReadyMainSection(context),
            _workoutActivityNotReadyButton(context)
          ],
        ),
      ),
    );
  }

  Widget _workoutActivityNotReadyMainSection(BuildContext context){
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Get Ready!",
            style: GoogleFonts.urbanist(color: AppTheme.primaryColor, fontWeight: FontWeight.w700, fontSize: 26.sp),
          ),
          _workoutActivityCircularTimer(context)
        ],
      ),
    );
  }

  Widget _workoutActivityNotReadyButton(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: CustomAppButton(
        height: 6.h,
        loading: false,
        label: "Start Over",
        onTap: () => _countDownController.start(),
      ),
    );
  }

  Widget _workoutActivityBackButton(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: (){
            if(_isRest){
              setState(() {
                _index--;
                _isRest = false;
              });
            }else{
              _countDownController.pause();
              CustomAppDialog.exitActivity(context, countDownController: _countDownController);
            }
          },
          child: Icon(Icons.arrow_back, size: 3.5.vmax, color: Colors.white,),
        ),
      ),
    );
  }

  Widget _workoutActivityCircularTimer(BuildContext context){
    return CircularCountDownTimer(
      duration: _duration,
      initialDuration: 0,
      controller: _countDownController,
      width: _isReady ? 25.w : 50.w,
      height: _isReady ? 25.h : 50.h,
      ringColor: AppTheme.ringTimerColor,
      fillColor: AppTheme.primaryColor,
      backgroundColor: AppTheme.scaffoldColor,
      strokeWidth: _isReady ? 15.0 : 20.0,
      strokeCap: StrokeCap.round,
      textStyle: GoogleFonts.urbanist(color: Colors.white, fontWeight: _isReady ? FontWeight.w700 : FontWeight.w900, fontSize: _isReady ? 26.sp : 34.sp),
      textFormat: CountdownTextFormat.S,
      isReverse: true,
      isReverseAnimation: true,
      isTimerTextShown: true,
      autoStart: true,
      onComplete: () {
        if(!_isReady){
          setState(() {
            _isReady = true;
            _duration = widget.workoutActivityModel[0].duration;
          });
        }else{
          if(_index == widget.workoutActivityModel.length - 1){
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.congratulationScreen,
              arguments: ScreenArgument<List<WorkoutActivityModel>>(widget.workoutActivityModel),
              (route) => false
            );
          }else{
            setState(() {
              _index++;
              _isRest = true;
            });
          }
        }
      },
      timeFormatterFunction: (defaultFormatterFunction, duration) => Function.apply(defaultFormatterFunction, [duration]),
    );
  }
}