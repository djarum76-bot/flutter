import 'package:bloc_firebase_login/cubit/complete_profile.dart';
import 'package:bloc_firebase_login/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompleteProfileScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CompleteProfileCubit(),
      child: Scaffold(
        appBar: AppBar(),
        body: _completeProfileView(context),
      ),
    );
  }

  Widget _completeProfileView(BuildContext context){
    final size = MediaQuery.of(context).size;
    return BlocListener<CompleteProfileCubit, CompleteProfileState>(
      listener: (context,state){
        if(state.status.isSubmissionFailure){
          ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text("Fail send data"))
              );
        }

        if(state.status.isSubmissionSuccess){
          Navigator.pushNamedAndRemoveUntil(context, Routes.profileScreen, (route) => false);
        }
      },
      child: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _nameInput(),
                SizedBox(height: 20,),
                _submitButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _nameInput(){
    return BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
      builder: (context, state){
        return TextFormField(
          onChanged: (name) => context.read<CompleteProfileCubit>().nameChanged(name),
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            labelText: "Name",
            errorText: state.name.invalid ? "Invalid Name" : null
          ),
          keyboardType: TextInputType.name,
        );
      },
    );
  }

  Widget _submitButton(){
    return BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
      builder: (context, state){
        return state.status.isSubmissionInProgress
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: (){
                  context.read<CompleteProfileCubit>().submit();
                },
                child: Text("Submit"),
              );
      },
    );
  }
}