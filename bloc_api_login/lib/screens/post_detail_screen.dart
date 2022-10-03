import 'package:bloc_api_login/cubit/post.dart';
import 'package:bloc_api_login/models/post_model.dart';
import 'package:bloc_api_login/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class PostDetailScreen extends StatelessWidget{
  const PostDetailScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PostCubit(),
        ),
        BlocProvider(
          create: (_) => PostCubit()..getPost(id),
        )
      ],
      child: Scaffold(
        body: _postDetailView(context),
      ),
    );
  }

  Widget _postDetailView(BuildContext context){
    return BlocListener<PostCubit, PostState>(
      listener: (context, state){
        if(state.status.isSubmissionFailure){
          ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text("Error"))
              );
        }

        if(state.status.isSubmissionSuccess){
          int count = 0;
          Navigator.popUntil(context, (route) => count++ == 2);
          Navigator.pushNamed(context, Routes.navbarScreen);
        }
      },
      child: _postDetailBody(context),
    );
  }

  Widget _postDetailBody(BuildContext context){
    final size = MediaQuery.of(context).size;
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state){
        if(state.postModel != null){
          return Container(
            width: size.width,
            height: size.height,
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    state.postModel!.data!.title!,
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
                const SizedBox(height: 6,),
                Text(state.postModel!.data!.body!),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: (){
                          Navigator.pushNamed(
                              context,
                              Routes.postEditScreen,
                              arguments: ScreenArguments<PostModel>(state.postModel!)
                          );
                        },
                        icon: Icon(Icons.edit)
                    ),
                    IconButton(
                        onPressed: (){
                          context.read<PostCubit>().deletePost(id);
                        },
                        icon: const Icon(Icons.delete)
                    )
                  ],
                )
              ],
            ),
          );
        }else{
          return const Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}