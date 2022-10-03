import 'package:bloc_ril_api_login/models/post_model.dart';
import 'package:bloc_ril_api_login/utils/routes.dart';
import 'package:formz/formz.dart';
import 'package:bloc_ril_api_login/bloc/post/post_bloc.dart';
import 'package:bloc_ril_api_login/repositories/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatelessWidget{
  const PostScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PostBloc(postRepository: RepositoryProvider.of(context)),
        ),
        BlocProvider(
          create: (context) => PostBloc(postRepository: RepositoryProvider.of<PostRepository>(context))..add(PostFetched(id)),
        )
      ],
      child: Scaffold(
        body: _bodyPost(context),
      ),
    );
  }

  Widget _bodyPost(BuildContext context){
    final size = MediaQuery.of(context).size;
    return BlocListener<PostBloc, PostState>(
      listener: (context,state){
        if(state.status.isSubmissionFailure){
          ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(state.message ?? "Error"))
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
          height: size.height,
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _postContent(),
              SizedBox(height: 10,),
              _postAction(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _postContent(){
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state){
        if(state.postModel == null){
          return Center(
            child: Text(state.message ?? "error"),
          );
        }else{
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(state.postModel!.data!.title!, style: TextStyle(fontSize: 30),),
              SizedBox(height: 5,),
              Text(state.postModel!.data!.body!),
            ],
          );
        }
      },
    );
  }

  Widget _postAction(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _deleteButton(context),
        SizedBox(width: 3,),
        _goToEditPage(context),
      ],
    );
  }

  Widget _deleteButton(BuildContext context){
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state){
        return state.status.isSubmissionInProgress
            ? CircularProgressIndicator()
            : IconButton(
                onPressed: (){
                  _deleteButtonFunction(context);
                },
                icon: Icon(Icons.delete),
              );
      },
    );
  }

  void _deleteButtonFunction(BuildContext context){
    BlocProvider.of<PostBloc>(context).add(PostDeleted(id));
  }

  Widget _goToEditPage(BuildContext){
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state){
        return state.postModel != null
            ? IconButton(
                onPressed: (){
                  Navigator.pushNamed(
                      context,
                      Routes.postEditScreen,
                      arguments: ScreenArguments<PostModel>(state.postModel!)
                  );
                },
                icon: Icon(Icons.edit),
              )
            : Container();
      },
    );
  }
}