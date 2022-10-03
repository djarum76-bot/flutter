import 'package:bloc_api_login/cubit/post_edit.dart';
import 'package:bloc_api_login/models/post_model.dart';
import 'package:bloc_api_login/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class PostEditScreen extends StatefulWidget{
  const PostEditScreen({super.key, required this.postModel});

  final PostModel postModel;

  @override
  State<PostEditScreen> createState() => _PostEditScreenState();
}

class _PostEditScreenState extends State<PostEditScreen> {
  late TextEditingController title;
  late TextEditingController body;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = TextEditingController(text: widget.postModel.data!.title!);
    body = TextEditingController(text: widget.postModel.data!.body!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostEditCubit(),
      child: Scaffold(
        body: _postEditView(context),
      ),
    );
  }

  Widget _postEditView(BuildContext context){
    final size = MediaQuery.of(context).size;
    return BlocListener<PostEditCubit, PostEditState>(
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
          Navigator.popUntil(context, (route) => count++ == 3);
          Navigator.pushNamed(
              context,
              Routes.navbarScreen,
          );
        }
      },
      child: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              _titleInput(),
              SizedBox(height: 10,),
              _bodyInput(),
              SizedBox(height: 10,),
              _editButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleInput(){
    return BlocBuilder<PostEditCubit, PostEditState>(
      builder: (context, state){
        return TextFormField(
          onChanged: (value) => context.read<PostEditCubit>().titleChanged(value),
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            labelText: "Title",
            errorText: state.title.invalid ? "Isi Bang" : null
          ),
          controller: title,
        );
      },
    );
  }

  Widget _bodyInput(){
    return BlocBuilder<PostEditCubit, PostEditState>(
      builder: (context, state){
        return TextFormField(
          onChanged: (value) => context.read<PostEditCubit>().bodyChanged(value),
          decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: "Body",
              errorText: state.body.invalid ? "Isi Bang" : null
          ),
          controller: body,
        );
      },
    );
  }

  Widget _editButton(){
    return BlocBuilder<PostEditCubit, PostEditState>(
      builder: (context, state){
        return state.status.isSubmissionInProgress
            ? CircularProgressIndicator()
            : ElevatedButton(
                  onPressed: (){
                    context.read<PostEditCubit>().submit(title.text, body.text, widget.postModel.data!.id!);
                  },
                  child: Text("Edit")
              );
      },
    );
  }
}