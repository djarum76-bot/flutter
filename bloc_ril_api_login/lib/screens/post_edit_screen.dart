import 'package:bloc_ril_api_login/bloc/post/post_bloc.dart';
import 'package:bloc_ril_api_login/models/post_model.dart';
import 'package:bloc_ril_api_login/repositories/post_repository.dart';
import 'package:bloc_ril_api_login/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:formz/formz.dart';

class PostEditScreen extends StatefulWidget{
  const PostEditScreen({super.key, required this.postModel});

  final PostModel postModel;

  @override
  State<PostEditScreen> createState() => _PostEditScreenState();
}

class _PostEditScreenState extends State<PostEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _title;
  late TextEditingController _body;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _title = TextEditingController(text: widget.postModel.data!.title);
    _body = TextEditingController(text: widget.postModel.data!.body);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _title.dispose();
    _body.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(postRepository: RepositoryProvider.of<PostRepository>(context)),
      child: Scaffold(
        body: _postEditView(context),
      ),
    );
  }

  Widget _postEditView(BuildContext context){
    final size = MediaQuery.of(context).size;
    return BlocListener<PostBloc, PostState>(
      listener: (context, state){
        if(state.status.isSubmissionFailure){
          ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(state.message ?? "Error"))
              );
        }

        if(state.status.isSubmissionSuccess){
          int count = 0;
          Navigator.popUntil(context, (route) => count++ == 3);
          Navigator.pushNamed(context, Routes.navbarScreen);
        }
      },
      child: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.all(10),
          child: _formEdit(context),
        ),
      ),
    );
  }

  Widget _formEdit(BuildContext context){
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          _titleInput(),
          SizedBox(height: 5,),
          _bodyInput(),
          SizedBox(height: 10,),
          _editButton(context)
        ],
      ),
    );
  }

  Widget _titleInput(){
    return TextFormField(
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: "Title",
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: _title,
      validator: ValidationBuilder().build(),
    );
  }

  Widget _bodyInput(){
    return TextFormField(
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: "Body",
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: _body,
      validator: ValidationBuilder().build(),
      maxLines: 5,
      keyboardType: TextInputType.multiline,
    );
  }

  Widget _editButton(BuildContext context){
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state){
        return state.status.isSubmissionInProgress
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: (){
                  _editButtonFunction(context);
                },
                child: Text("Edit"),
              );
      },
    );
  }

  void _editButtonFunction(BuildContext context){
    if(_formKey.currentState!.validate()){
      BlocProvider.of<PostBloc>(context).add(PostUpdated(widget.postModel.data!.id!, _title.text, _body.text));
    }
  }
}