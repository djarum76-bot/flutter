
import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_bloc/bloc/post/post_bloc.dart';
import 'package:instagram_bloc/components/scaffold_message.dart';
import 'package:instagram_bloc/models/post_model.dart';
import 'package:instagram_bloc/utils/any_service.dart';
import 'package:instagram_bloc/utils/constants.dart';
import 'package:instagram_bloc/utils/routes.dart';

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
    return BlocListener<PostBloc, PostState>(
      listener: (context, state){
        if(state.status.isSubmissionFailure){
          scaffoldMessage(context, state.message ?? "Error");
        }

        if(state.status.isSubmissionSuccess){
          scaffoldMessage(context, "Success");
        }
      },
      child: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          child: _homeList(context),
        ),
      ),
    );
  }

  Widget _homeList(BuildContext context){
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state){
        if(state.posts == <PostModel>[]){
          return Center(
            child: Text("No Post"),
          );
        }
        if(state.posts != <PostModel>[]){
          return ListView.builder(
            itemCount: state.posts.length,
            itemBuilder: (context, index){
              var post = state.posts[index];
              return _homeListItem(context, post);
            },
          );
        }
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }

  Widget _homeListItem(BuildContext context, PostModel post){
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 4),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                _userPhoto(post.user!.picture!.string!),
                SizedBox(width: 4,),
                Text(
                  post.user!.username!,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          Container(
            width: size.width,
            height: size.height * 0.35,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("${Constants.baseURL}/${post.post!.image!}"),
                fit: BoxFit.cover
              )
            ),
          ),
          _postAction(context, post),
          _likeBy(post.post!.likes!),
          _caption(post.post!.caption!),
        ],
      ),
    );
  }

  Widget _postAction(BuildContext context, PostModel post){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                _likeButton(post),
                IconButton(
                  onPressed: (){
                    Navigator.pushNamed(
                      context,
                      Routes.commentScreen,
                      arguments: ScreenArgument<int>(post.post!.id!)
                    );
                  },
                  icon: Icon(Icons.comment_outlined),
                )
              ],
            ),
          ),
          _deleteButton(context, post.user!.id!, post.post!.id!)
        ],
      ),
    );
  }

  Widget _likeButton(PostModel post){
    bool isLike = false;
    int id = 0;
    for(int i = 0; i < post.post!.likes!.length; i++){
      if(post.post!.likes![i].userId! == box.read(Constants.id)){
        isLike = true;
        id = post.post!.likes![i].id!;
        break;
      }
    }

    if(isLike){
      return BlocBuilder<PostBloc, PostState>(
        builder: (context, state){
          return state.status.isSubmissionInProgress
              ? CircularProgressIndicator()
              : IconButton(
                  onPressed: (){
                    BlocProvider.of<PostBloc>(context).add(
                      UnlikePost(id)
                    );
                  },
                  icon: Icon(Icons.favorite, color: Colors.pink,),
                );
        },
      );
    }else{
      return BlocBuilder<PostBloc, PostState>(
        builder: (context, state){
          return state.status.isSubmissionInProgress
              ? CircularProgressIndicator()
              : IconButton(
                  onPressed: (){
                    BlocProvider.of<PostBloc>(context).add(
                        LikePost(post.post!.id!)
                    );
                  },
                  icon: Icon(Icons.favorite_border),
                );
        },
      );
    }
  }

  Widget _deleteButton(BuildContext context, int userID, int postID){
    if(box.read(Constants.id) == userID){
      return BlocBuilder<PostBloc, PostState>(
        builder: (context, state){
          return state.status.isSubmissionInProgress
              ? CircularProgressIndicator()
              : IconButton(
            onPressed: (){
              _deleteButtonFunction(context, postID);
            },
            icon: Icon(Icons.delete),
          );
        },
      );
    }else{
      return SizedBox();
    }
  }

  void _deleteButtonFunction(BuildContext context, int postID){
    BlocProvider.of<PostBloc>(context).add(
        PostDeleted(postID)
    );
  }

  Widget _likeBy(List<Like> likes){
    if(likes.isEmpty){
      return SizedBox();
    }else{
      return Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
              "Disukai oleh ${likes.length} orang",
              style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      );
    }
  }

  Widget _caption(String caption){
    if(caption == ""){
      return SizedBox();
    }else{
      return Padding(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(caption),
        ),
      );
    }
  }

  Widget _userPhoto(String image){
    if(image == ""){
      return CircleAvatar(
        backgroundImage: AssetImage("asset/download.png"),
      );
    }else{
      return CircleAvatar(
        backgroundImage: NetworkImage("${Constants.baseURL}/$image"),
      );
    }
  }
}