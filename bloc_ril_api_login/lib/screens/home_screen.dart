import 'package:bloc_ril_api_login/utils/routes.dart';
import 'package:formz/formz.dart';
import 'package:bloc_ril_api_login/bloc/posts/posts_bloc.dart';
import 'package:bloc_ril_api_login/bloc/posts/posts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _homeView(context),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, Routes.postAddScreen);
        },
      ),
    );
  }

  Widget _homeView(BuildContext context){
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.all(10),
        child: _homePosts(),
      ),
    );
  }

  Widget _homePosts(){
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state){
        if(state.status.isSubmissionFailure){
          return Center(
            child: Text(state.message ?? "Error"),
          );
        }
        if(state.status.isSubmissionSuccess){
          return ListView.builder(
            itemCount: state.postsModel!.data!.length,
            itemBuilder: (context, index){
              var data = state.postsModel!.data![index];
              return ListTile(
                onTap: (){
                  Navigator.pushNamed(
                      context,
                      Routes.postScreen,
                      arguments: ScreenArguments<int>(data.id!)
                  );
                },
                leading: Text(
                  index.toString(), style: TextStyle(fontSize: 22),
                ),
                title: Text(data.title!),
                subtitle: Text(data.body!),
              );
            },
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}