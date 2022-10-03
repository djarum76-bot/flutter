import 'dart:io';
import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:instagram_bloc/bloc/user/user_bloc.dart';
import 'package:instagram_bloc/components/scaffold_message.dart';
import 'package:instagram_bloc/cubit/password_cubit.dart';
import 'package:instagram_bloc/repositories/user_repository.dart';
import 'package:instagram_bloc/utils/routes.dart';

class CompleteProfileScreen extends StatefulWidget{
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _phone;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phone = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phone.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => UserBloc(userRepository: RepositoryProvider.of<UserRepository>(context)),
        child: _completeProfileView(context),
      ),
    );
  }

  Widget _completeProfileView(BuildContext context){
    final size = MediaQuery.of(context).size;
    return BlocListener<UserBloc, UserState>(
      listener: (context,state){
        if(state.status.isSubmissionFailure){
          scaffoldMessage(context, state.message ?? "Error");
        }
        if(state.status.isSubmissionSuccess){
          Navigator.pushNamedAndRemoveUntil(context, Routes.navbarScreen, (route) => false);
        }
      },
      child: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.all(10),
          child:_formInput(context),
        ),
      ),
    );
  }

  Widget _formInput(BuildContext context){
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          _phoneInput(),
          SizedBox(height: 5,),
          _imageForm(context),
          SizedBox(height: 10,),
          _submitButton(context)
        ],
      ),
    );
  }

  Widget _phoneInput(){
    return TextFormField(
      decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: "Phone"
      ),
      controller: _phone,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.phone,
      validator: ValidationBuilder().phone("Invalid phone number").build(),
    );
  }

  Widget _imageForm(BuildContext context){
    final size = MediaQuery.of(context).size;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state){
        return GestureDetector(
          onTap: (){
            BlocProvider.of<UserBloc>(context).add(
              TakePicture()
            );
          },
          child: Container(
            width: size.width,
            height: size.height * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black)
            ),
            child: state.image == null
              ? _noImage()
              : _haveImage(context, state.image!)
          ),
        );
      },
    );
  }

  Widget _noImage(){
    return Center(
      child: Icon(Icons.camera),
    );
  }

  Widget _haveImage(BuildContext context, String state){
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
        image: DecorationImage(
          image: FileImage(File(state)),
          fit: BoxFit.contain
        )
      ),
    );
  }

  Widget _submitButton(BuildContext context){
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state){
        return state.status.isSubmissionInProgress
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: (){
                  _submitButtonFunction(context, state);
                },
                child: Text("Submit"),
              );
      },
    );
  }

  void _submitButtonFunction(BuildContext context, UserState state){
    if(_formKey.currentState!.validate() && (state.image != null)){
      BlocProvider.of<UserBloc>(context).add(
        CompleteProfile(_phone.text, state.image!)
      );
    }
  }
}