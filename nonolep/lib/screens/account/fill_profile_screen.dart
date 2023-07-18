import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nonolep/bloc/user/user_bloc.dart';
import 'package:nonolep/components/button/custom_app_button.dart';
import 'package:nonolep/components/custom_app_dialog.dart';
import 'package:nonolep/models/user_model.dart';
import 'package:nonolep/services/local/local_storage.dart';
import 'package:nonolep/utils/app_routes.dart';
import 'package:nonolep/utils/app_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FillProfileScreen extends StatefulWidget{
  const FillProfileScreen({super.key, required this.email});
  final String email;

  @override
  State<FillProfileScreen> createState() => _FillProfileScreenState();
}

class _FillProfileScreenState extends State<FillProfileScreen> {
  late LocalStorage _storage;
  late UserModel _user;
  late String _picture;
  late TextEditingController _name;
  late TextEditingController _email;
  late TextEditingController _phone;

  @override
  void initState() {
    _storage = LocalStorage.instance;
    _picture = "";
    _name = TextEditingController();
    _email = TextEditingController(text: widget.email);
    _phone = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => CustomAppDialog.exitApplication(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _fillProfileBody(context),
      ),
    );
  }

  Widget _fillProfileBody(BuildContext context){
    return BlocListener<UserBloc, UserState>(
      listener: (context, state){
        if(state.status == UserStatus.loading){
          CustomAppDialog.loadingDialog(context);
        }

        if(state.status == UserStatus.error){
          CustomAppDialog.errorDialog(context, message: state.message ?? "Error");
        }

        if(state.status == UserStatus.updated){
          BlocProvider.of<UserBloc>(context).add(UserFetched());
        }

        if(state.status == UserStatus.fetched){
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashboardScreen, (route) => false);
        }
      },
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 6.w,  vertical: 3.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _fillProfileUpperSection(),
              _fillProfileMainSection(context),
              _fillProfileSubmitButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _fillProfileUpperSection(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Fill Your Profile",
          style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 24.sp),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 1.5.h,),
        Text(
          "Don't worry, you can always change it later, or you can skip it for now",
          style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17.sp),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget _fillProfileMainSection(BuildContext context){
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5.h,),
              _fillProfilePictureSection(context),
              SizedBox(height: 4.h),
              _fillProfileNameForm(),
              SizedBox(height: 2.h),
              _fillProfileEmailForm(),
              SizedBox(height: 2.h),
              _fillProfilePhoneForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fillProfilePictureSection(BuildContext context){
    return Stack(
      children: [
        _fillProfilePictureCircle(),
        _fillProfilePictureButton(context)
      ],
    );
  }

  Widget _fillProfilePictureCircle(){
    if(_picture == ""){
      return CircleAvatar(
        radius: 9.vmax,
        backgroundColor: AppTheme.onScaffoldColor,
        backgroundImage: const AssetImage("assets/images/default-user.png"),
      );
    }else{
      return CircleAvatar(
        radius: 9.vmax,
        backgroundColor: AppTheme.onScaffoldColor,
        backgroundImage: FileImage(File(_picture)),
      );
    }
  }

  Widget _fillProfilePictureButton(BuildContext context){
    return Positioned(
      bottom: 0,
      right: 0,
      child: GestureDetector(
        onTap: () => _fillProfilePictureOptionModal(context),
        child: Container(
          height: 4.h,
          width: 8.w,
          decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(8)
          ),
          child: const Center(
            child: Icon(Icons.edit, color: Colors.black,),
          ),
        ),
      ),
    );
  }

  Future<void> _fillProfilePictureOptionModal(BuildContext context)async{
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context){
          return _fillProfilePictureOptionBottomSheet(context);
        }
    );
  }

  Widget _fillProfilePictureOptionBottomSheet(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: AppTheme.onScaffoldColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )
        ),
        padding: EdgeInsets.fromLTRB(4.5.w, 2.h, 4.5.w, MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Change Profile Photo",
              style: GoogleFonts.urbanist(fontWeight: FontWeight.w600, fontSize: 18.sp, color: Colors.white),
            ),
            SizedBox(height: 3.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _fillProfilePictureOptionButton(context, source: ImageSource.gallery, color: const Color(0xFFFBB040), icon: "assets/svg/gallery.svg", label: "Gallery"),
                SizedBox(width: 8.w),
                _fillProfilePictureOptionButton(context, source: ImageSource.camera, color: const Color(0xFFFD5656), icon: "assets/svg/camera.svg", label: "Camera")
              ],
            ),
            SizedBox(height: 2.h,),
          ],
        ),
      ),
    );
  }

  Widget _fillProfilePictureOptionButton(BuildContext context, {required ImageSource source, required Color color, required String icon, required String label}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: ()async{
            final XFile? image = await ImagePicker().pickImage(source: source);
            if(!mounted) return;
            Navigator.pop(context);

            if(image != null){
              setState(() {
                _picture = image.path;
              });
            }else{
              CustomAppDialog.errorDialog(context, message: "No Image Selected");
            }
          },
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: 17.25.w,
              height: 8.25.h,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(16)
              ),
              child: Center(
                child: SvgPicture.asset(icon),
              ),
            ),
          ),
        ),
        SizedBox(height: 1.5.h),
        Text(
          label,
          style: GoogleFonts.urbanist(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 14.sp),
        )
      ],
    );
  }

  Widget _fillProfileNameForm(){
    return TextFormField(
      controller: _name,
      keyboardType: TextInputType.name,
      style: GoogleFonts.urbanist(color: Colors.white),
      decoration: AppTheme.inputDecoration(hintText: "Full Name"),
    );
  }

  Widget _fillProfileEmailForm(){
    return TextFormField(
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      readOnly: true,
      style: GoogleFonts.urbanist(color: Colors.white),
      decoration: AppTheme.inputSuffixIconDecoration(icon: LineIcons.envelope, hintText: "Email"),
    );
  }

  Widget _fillProfilePhoneForm(){
    return TextFormField(
      controller: _phone,
      keyboardType: TextInputType.phone,
      style: GoogleFonts.urbanist(color: Colors.white),
      decoration: AppTheme.inputPhoneDecoration(hintText: "Phone Number"),
    );
  }

  Widget _fillProfileSubmitButton(BuildContext  context){
    return Row(
      children: [
        Expanded(
          child: CustomAppButton(
            height: 6.h,
            loading: false,
            label: "Skip",
            backgroundColor: AppTheme.onScaffoldColor,
            onTap: () => BlocProvider.of<UserBloc>(context).add(UserUpdated()),
          ),
        ),
        SizedBox(width: 3.w,),
        Expanded(
          child: CustomAppButton(
            height: 6.h,
            loading: false,
            label: "Start",
            onTap: ()async{
              _user = await _storage.user;
              _user.picture = _picture;
              _user.name = _name.text;
              _user.phone = _phone.text;

              await _user.save().then((value){
                BlocProvider.of<UserBloc>(context).add(UserUpdated());
              });
            },
          ),
        )
      ],
    );
  }
}