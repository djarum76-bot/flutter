import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nonolep/bloc/user/user_bloc.dart';
import 'package:nonolep/components/button/custom_app_button.dart';
import 'package:nonolep/components/custom_app_bar.dart';
import 'package:nonolep/components/custom_app_dialog.dart';
import 'package:nonolep/models/user_model.dart';
import 'package:nonolep/services/local/local_storage.dart';
import 'package:nonolep/utils/app_theme.dart';
import 'package:nonolep/utils/constants/app_constant.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditProfileScreen extends StatefulWidget{
  const EditProfileScreen({super.key, required this.user});
  final UserModel user;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late LocalStorage _storage;
  late UserModel _user;
  late GlobalKey<FormState> _formKey;
  late TextEditingController _name;
  late TextEditingController _email;
  late TextEditingController _phone;
  late SingleValueDropDownController _gender;

  @override
  void initState() {
    _storage = LocalStorage.instance;
    _formKey = GlobalKey<FormState>();
    _name = TextEditingController(text: widget.user.name);
    _email = TextEditingController(text: widget.user.email);
    _phone = TextEditingController(text: widget.user.phone);
    _gender = SingleValueDropDownController(
      data: DropDownValueModel(name: widget.user.gender!, value: widget.user.gender)
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar.withArrowBackLogo(title: "Edit Profile"),
      body: _editProfileBody(context),
    );
  }

  Widget _editProfileBody(BuildContext context){
    return BlocListener<UserBloc, UserState>(
      listener: (context, state){
        if(state.status == UserStatus.error){
          CustomAppDialog.errorDialog(context, message: state.message ?? "Error");
        }

        if(state.status == UserStatus.updated){
          BlocProvider.of<UserBloc>(context).add(UserFetched());
        }

        if(state.status == UserStatus.fetched){
          Navigator.pop(context);
        }
      },
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Column(
            children: [
              _editProfileForm(),
              _editProfileButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _editProfileForm(){
    return Expanded(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _editProfileNameForm(),
            SizedBox(height: 3.h),
            _editProfileEmailForm(),
            SizedBox(height: 3.h),
            _editProfilePhoneForm(),
            SizedBox(height: 3.h),
            _editProfileGenderForm()
          ],
        ),
      ),
    );
  }

  Widget _editProfileNameForm(){
    return TextFormField(
      controller: _name,
      keyboardType: TextInputType.name,
      style: GoogleFonts.urbanist(color: Colors.white),
      decoration: AppTheme.inputDecoration(hintText: "Full Name"),
      validator: ValidationBuilder().build(),
    );
  }

  Widget _editProfileEmailForm(){
    return TextFormField(
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      readOnly: true,
      style: GoogleFonts.urbanist(color: Colors.white),
      decoration: AppTheme.inputDecoration(hintText: "Full Name"),
    );
  }

  Widget _editProfilePhoneForm(){
    return TextFormField(
      controller: _phone,
      keyboardType: TextInputType.phone,
      style: GoogleFonts.urbanist(color: Colors.white),
      decoration: AppTheme.inputPhoneDecoration(hintText: "Phone Number"),
    );
  }

  Widget _editProfileGenderForm(){
    return DropDownTextField(
      controller: _gender,
      validator: ValidationBuilder().build(),
      clearOption: false,
      dropDownIconProperty: IconProperty(color: Colors.white),
      textStyle: GoogleFonts.urbanist(color: Colors.white),
      textFieldDecoration: AppTheme.inputDecoration(hintText: "Gender"),
      dropDownList: const [
        DropDownValueModel(
            name: AppConstant.male,
            value: AppConstant.male
        ),
        DropDownValueModel(
          name: AppConstant.female,
          value: AppConstant.female,
        )
      ],
      dropDownItemCount: 2,
    );
  }

  Widget _editProfileButton(BuildContext context){
    return CustomAppButton(
      loading: false,
      height: 6.h,
      label: "Update",
      onTap: ()async{
        if(_formKey.currentState!.validate()){
          if((_name.text == widget.user.name) && (_phone.text == widget.user.phone) && (_gender.dropDownValue!.name == widget.user.gender) && (_gender.dropDownValue!.value == widget.user.gender)){
            Navigator.pop(context);
          }else{
            _user = await _storage.user;

            _user.picture = "";
            _user.name = _name.text;
            _user.phone = _phone.text;
            _user.gender = _gender.dropDownValue!.name;

            await _user.save().then((value){
              BlocProvider.of<UserBloc>(context).add(UserUpdated());
            });
          }
        }
      },
    );
  }
}