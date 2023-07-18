import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nonolep/bloc/user/user_bloc.dart';
import 'package:nonolep/components/custom_app_bar.dart';
import 'package:nonolep/components/custom_app_dialog.dart';
import 'package:nonolep/models/user_model.dart';
import 'package:nonolep/services/local/local_storage.dart';
import 'package:nonolep/utils/app_routes.dart';
import 'package:nonolep/utils/app_theme.dart';
import 'package:nonolep/utils/screen_argument.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileScreen extends StatefulWidget{
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late LocalStorage _storage;
  late UserModel _user;
  late String _image;
  
  @override
  void initState() {
    _storage = LocalStorage.instance;
    _image = "";
    if(BlocProvider.of<UserBloc>(context).state.user == null){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        BlocProvider.of<UserBloc>(context).add(UserFetched());
      });
    }
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => CustomAppDialog.exitApplication(context),
      child: Scaffold(
        appBar: CustomAppBar.withLogoApp(
            title: "Profile",
            actions: [
              GestureDetector(
                onTap: (){},
                child: Icon(Icons.pending_outlined, size: 3.5.vmax, color: Colors.white,),
              ),
              SizedBox(width: 2.45.w,),
            ]
        ),
        body: _profileBody(context),
      ),
    );
  }

  Widget _profileBody(BuildContext context){
    return BlocListener<UserBloc, UserState>(
      listener: (context, state)async{
        if(state.status == UserStatus.unauthenticated){
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.authenticationScreen, (route) => false);
        }

        if(state.status == UserStatus.error){
          CustomAppDialog.errorDialog(context, message: state.message ?? "Error");
        }
      },
      child: SafeArea(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state){
            if((state.status != UserStatus.fetched) && (state.status != UserStatus.error) || (state.user == null)){
              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: LoadingAnimationWidget.prograssiveDots(
                    color: AppTheme.primaryColor,
                    size: 10.vmax,
                  ),
                ),
              );
            }else{
              return Container(
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 0),
                child: Column(
                  children: [
                    _profileImageSection(context),
                    SizedBox(height: 2.5.h,),
                    Text(
                      state.user!.name == "" ? "-" : state.user!.name!,
                      style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 22.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 0.5.h,),
                    Text(
                      state.user!.email!,
                      style: GoogleFonts.urbanist(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 2.5.h,),
                    Container(
                      height: 0.1.h,
                      width: double.infinity,
                      color: AppTheme.separatorLineColor,
                    ),
                    SizedBox(height: 2.5.h,),
                    _profileActionButton(
                        context,
                        onTap: ()async{
                          _user = await _storage.user;

                          if(state.user == null){
                            if(!mounted) return;
                            CustomAppDialog.errorDialog(context, message: "User data is null");
                          }else{
                            if(_user == state.user){
                              if(!mounted) return;
                              Navigator.pushNamed(
                                  context,
                                  AppRoutes.editProfileScreen,
                                  arguments: ScreenArgument<UserModel>(_user)
                              );
                            }else{
                              _user = state.user!;
                              await _user.save().then((value){
                                Navigator.pushNamed(
                                    context,
                                    AppRoutes.editProfileScreen,
                                    arguments: ScreenArgument<UserModel>(_user)
                                );
                              });
                            }
                          }
                        },
                        icon: LineIcons.user,
                        label: "Edit Profile",
                        color: Colors.white
                    ),
                    SizedBox(height: 1.h,),
                    _profileActionButton(
                        context,
                        onTap: () => CustomAppDialog.logoutDialog(context),
                        icon: LineIcons.doorOpen,
                        label: "Logout",
                        color: AppTheme.redColor
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _profileImageSection(BuildContext context){
    return Stack(
      children: [
        _profileImageCircle(),
        _profileImageButton(context)
      ],
    );
  }

  Widget _profileImageCircle(){
    if(_image == ""){
      return CircleAvatar(
        radius: 9.vmax,
        backgroundColor: AppTheme.onScaffoldColor,
        backgroundImage: const AssetImage("assets/images/default-user.png"),
      );
    }else{
      return CircleAvatar(
        radius: 9.vmax,
        backgroundColor: AppTheme.onScaffoldColor,
        backgroundImage: FileImage(File(_image)),
      );
    }
  }

  Widget _profileImageButton(BuildContext context){
    return Positioned(
      bottom: 0,
      right: 0,
      child: GestureDetector(
        onTap: () => _profileImageOptionModal(context),
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

  Future<void> _profileImageOptionModal(BuildContext context)async{
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context){
          return _profileImageOptionBottomSheet(context);
        }
    );
  }

  Widget _profileImageOptionBottomSheet(BuildContext context){
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
                _profileImageOptionButton(context, source: ImageSource.gallery, color: const Color(0xFFFBB040), icon: "assets/svg/gallery.svg", label: "Gallery"),
                SizedBox(width: 8.w),
                _profileImageOptionButton(context, source: ImageSource.camera, color: const Color(0xFFFD5656), icon: "assets/svg/camera.svg", label: "Camera")
              ],
            ),
            SizedBox(height: 2.h,),
          ],
        ),
      ),
    );
  }

  Widget _profileImageOptionButton(BuildContext context, {required ImageSource source, required Color color, required String icon, required String label}){
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
                _image = image.path;
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

  Widget _profileActionButton(BuildContext context, {required void Function() onTap, required IconData icon, required String label, required Color color}){
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: 5.5.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 4.vmax,),
            SizedBox(width: 3.w,),
            Text(
              label,
              style: GoogleFonts.urbanist(color: color, fontWeight: FontWeight.w600, fontSize: 18.sp),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}