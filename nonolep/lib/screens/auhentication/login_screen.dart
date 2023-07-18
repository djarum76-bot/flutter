import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nonolep/bloc/user/user_bloc.dart';
import 'package:nonolep/components/button/custom_app_button.dart';
import 'package:nonolep/components/custom_app_dialog.dart';
import 'package:nonolep/cubit/obscure_cubit.dart';
import 'package:nonolep/services/local/local_storage.dart';
import 'package:nonolep/utils/app_routes.dart';
import 'package:nonolep/utils/app_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LocalStorage _storage;
  late GlobalKey<FormState> _formKey;
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    _storage = LocalStorage.instance;
    _formKey = GlobalKey<FormState>();
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ObscureCubit(),
      child: WillPopScope(
        onWillPop: () => CustomAppDialog.exitApplication(context),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: _loginBody(context),
        ),
      ),
    );
  }

  Widget _loginBody(BuildContext context){
    return BlocListener<UserBloc, UserState>(
      listener: (context, state)async{
        if(state.status == UserStatus.error){
          await _storage.deleteData().then((value){
            CustomAppDialog.errorDialog(context, message: state.message ?? "Error");
          });
        }

        if(state.status == UserStatus.authenticated){
          if(!mounted) return;
          BlocProvider.of<UserBloc>(context).add(UserFetched());
        }

        if(state.status == UserStatus.fetched){
          if(state.user!.isFilled!){
            if(!mounted) return;
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashboardScreen, (route) => false);
          }else{
            if(!mounted) return;
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.genderScreen, (route) => false);
          }
        }
      },
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 6.w,  vertical: 3.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 2.h),
              _loginText(),
              _loginMainSection(context),
              _loginSeparator(),
              _loginSocialMediaButtonList(),
              _loginBottomSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginText(){
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        "Login to your Account",
        style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 29.sp),
      ),
    );
  }

  Widget _loginMainSection(BuildContext context){
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _loginEmailForm(),
          SizedBox(height: 2.h),
          _loginPasswordForm(context),
          SizedBox(height: 4.h),
          _loginSubmitButton(context),
        ],
      ),
    );
  }

  Widget _loginEmailForm(){
    return TextFormField(
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      style: GoogleFonts.urbanist(color: Colors.white),
      decoration: AppTheme.inputPrefixIconDecoration(icon: LineIcons.envelope, hintText: "Email"),
      validator: ValidationBuilder().email('Not Valid Email').build(),
    );
  }

  Widget _loginPasswordForm(BuildContext context){
    return BlocBuilder<ObscureCubit, bool>(
      builder: (context, state){
        return TextFormField(
          controller: _password,
          keyboardType: TextInputType.text,
          obscureText: state,
          style: GoogleFonts.urbanist(color: Colors.white),
          decoration: AppTheme.inputPasswordDecoration(
              state: state,
              onTap: () => context.read<ObscureCubit>().changeStatus(),
              hintText: "Password"
          ),
          validator: ValidationBuilder().minLength(8,"Enter min 8 character").build(),
        );
      },
    );
  }

  Widget _loginSubmitButton(BuildContext context){
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state){
        if(state.status == UserStatus.loading){
          return CustomAppButton(
            height: 6.h,
            loading: true,
          );
        }else{
          return CustomAppButton(
            height: 6.h,
            loading: false,
            label: "Sign in",
            onTap: (){
              if(_formKey.currentState!.validate()){
                BlocProvider.of<UserBloc>(context).add(UserLogin(_email.text, _password.text));
              }
            },
          );
        }
      },
    );
  }

  Widget _loginSeparator(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 0.1.h,
          width: 27.5.w,
          color: AppTheme.separatorLineColor,
        ),
        Text(
          "or continue with",
          style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 16.sp, color: Colors.white),
        ),
        Container(
          height: 0.1.h,
          width: 27.5.w,
          color: AppTheme.separatorLineColor,
        )
      ],
    );
  }

  Widget _loginSocialMediaButtonList(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomAppButton(
          loading: false,
          iconData: LineIcons.facebook,
          iconColor: Colors.blue,
          backgroundColor: AppTheme.onScaffoldColor,
          borderColor: AppTheme.greyBorderColor,
          height: 8.h,
          width: 20.w,
          radius: 16,
          onTap: (){},
        ),
        SizedBox(width: 3.w,),
        CustomAppButton(
          loading: false,
          iconData: LineIcons.googleLogo,
          iconColor: Colors.red,
          backgroundColor: AppTheme.onScaffoldColor,
          borderColor: AppTheme.greyBorderColor,
          height: 8.h,
          width: 20.w,
          radius: 16,
          onTap: (){},
        ),
        SizedBox(width: 3.w,),
        CustomAppButton(
          loading: false,
          iconData: LineIcons.apple,
          iconColor: Colors.white,
          backgroundColor: AppTheme.onScaffoldColor,
          borderColor: AppTheme.greyBorderColor,
          height: 8.h,
          width: 20.w,
          radius: 16,
          onTap: (){},
        )
      ],
    );
  }

  Widget _loginBottomSection(BuildContext context){
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