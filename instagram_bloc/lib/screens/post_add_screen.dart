import 'dart:io';
import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_bloc/bloc/post/post_bloc.dart';
import 'package:instagram_bloc/components/scaffold_message.dart';
import 'package:instagram_bloc/repositories/post_repository.dart';
import 'package:instagram_bloc/utils/routes.dart';

class PostAddScreen extends StatefulWidget{
  const PostAddScreen({super.key});

  @override
  State<PostAddScreen> createState() => _PostAddScreenState();
}

class _PostAddScreenState extends State<PostAddScreen> {
  late TextEditingController _caption;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _caption = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _caption.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _postAddView(context),
    );
  }

  Widget _postAddView(BuildContext context){
    final size = MediaQuery.of(context).size;
    return BlocListener<PostBloc, PostState>(
      listener: (context, state){
        if(state.status.isSubmissionFailure){
          scaffoldMessage(context, state.message ?? "Error");
        }

        if(state.status.isSubmissionSuccess){
          Navigator.pop(context);
        }
      },
      child: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              _captionInput(),
              SizedBox(height: 5,),
              _imageForm(context),
              SizedBox(height: 10,),
              _addButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _captionInput(){
    return TextFormField(
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: "Caption"
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: _caption,
      keyboardType: TextInputType.multiline,
      maxLines: null,
    );
  }

  Widget _imageForm(BuildContext context){
    final size = MediaQuery.of(context).size;
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state){
        return GestureDetector(
          onTap: (){
            BlocProvider.of<PostBloc>(context).add(
              TakeImage()
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
          fit: BoxFit.cover
        )
      ),
    );
  }

  Widget _addButton(BuildContext context){
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state){
        return state.status.isSubmissionInProgress
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: (){
                  _addButtonFunction(context, state.image);
                },
                child: Text("Add"),
              );
      },
    );
  }

  void _addButtonFunction(BuildContext context, String? image){
    if(image != null){
      BlocProvider.of<PostBloc>(context).add(
        CreatePost(image, _caption.text)
      );
    }
  }
}