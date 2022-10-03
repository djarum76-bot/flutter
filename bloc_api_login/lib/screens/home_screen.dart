import 'package:bloc_api_login/cubit/posts.dart';
import 'package:bloc_api_login/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostsCubit()..getAllPost(),
      child: Scaffold(
        body: _homeView(context),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, Routes.postAddScreen);
          },
        ),
      ),
    );
  }

  Widget _homeView(BuildContext context){
    final size = MediaQuery.of(context).size;
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state){
        if(state.postsModel != null){
          return SafeArea(
            child: Container(
              width: size.width,
              height: size.height,
              padding: EdgeInsets.all(6),
              child: ListView.builder(
                itemCount: state.postsModel!.data!.length,
                itemBuilder: (context, index){
                  var data = state.postsModel!.data![index];
                  return ListTile(
                    onTap: (){
                      Navigator.pushNamed(
                          context,
                          Routes.postDetailScreen,
                          arguments: ScreenArguments<int>(data.id!)
                      );
                    },
                    leading: Text(
                      "${index+1}",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    title: Text(data.title!),
                    subtitle: Text(data.body!),
                  );
                },
              ),
            ),
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}