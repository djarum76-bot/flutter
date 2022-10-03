import 'package:bloc_api_login/cubit/post_add.dart';
import 'package:bloc_api_login/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class PostAddScreen extends StatelessWidget{
  const PostAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostAddCubit(),
      child: Scaffold(
        body: _postAddView(context),
      ),
    );
  }

  Widget _postAddView(BuildContext context){
    final size = MediaQuery.of(context).size;
    return BlocListener<PostAddCubit, PostAddState>(
      listener: (context, state){
        if(state.status.isSubmissionFailure){
          ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text("Error"))
              );
        }

        if(state.status.isSubmissionSuccess){
          int count = 0;
          Navigator.popUntil(context, (route) => count++ == 2);
          Navigator.pushNamed(context, Routes.navbarScreen);
        }
      },
      child: SafeArea(
        child: Container(
          width: size.width,
          height: size.width,
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              _postAddTitleInput(),
              SizedBox(height: 10,),
              _postAddBodyInput(),
              SizedBox(height: 10,),
              _postAddButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _postAddTitleInput(){
    return BlocBuilder<PostAddCubit, PostAddState>(
      builder: (context, state){
        return TextFormField(
          onChanged: (value) => context.read<PostAddCubit>().titleChanged(value),
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            labelText: "Title",
            errorText: state.title.invalid ? "Invalid Title" : null
          ),
        );
      },
    );
  }

  Widget _postAddBodyInput(){
    return BlocBuilder<PostAddCubit, PostAddState>(
      builder: (context, state){
        return TextFormField(
          onChanged: (value) => context.read<PostAddCubit>().bodyChanged(value),
          decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: "Body",
              errorText: state.body.invalid ? "Invalid Body" : null
          ),
          maxLines: 3,
          keyboardType: TextInputType.multiline,
        );
      },
    );
  }

  Widget _postAddButton(){
    return BlocBuilder<PostAddCubit, PostAddState>(
      builder: (context, state){
        return state.status.isSubmissionInProgress
            ? CircularProgressIndicator()
            : ElevatedButton(
                  onPressed: (){
                    context.read<PostAddCubit>().submit();
                  },
                  child: Text("SUBMIT")
              );
      },
    );
  }
}