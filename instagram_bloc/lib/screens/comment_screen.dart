import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_bloc/bloc/comment/comment_bloc.dart';
import 'package:instagram_bloc/components/scaffold_message.dart';
import 'package:instagram_bloc/models/comment_model.dart';
import 'package:instagram_bloc/repositories/comment_repository.dart';
import 'package:instagram_bloc/utils/constants.dart';
import 'package:formz/formz.dart';

class CommentScreen extends StatefulWidget{
  const CommentScreen({super.key, required this.id});

  final int id;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  late TextEditingController _comment;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _comment = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _comment.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CommentBloc(commentRepository: RepositoryProvider.of<CommentRepository>(context)),
        ),
        BlocProvider(
          create: (context) => CommentBloc(commentRepository: RepositoryProvider.of<CommentRepository>(context))..add(CommentFetched(widget.id)),
        )
      ],
      child: Scaffold(
        body: _commentView(context),
      ),
    );
  }

  Widget _commentView(BuildContext context){
    return BlocListener<CommentBloc, CommentState>(
      listener: (context, state){
        if(state.status.isSubmissionFailure){
          scaffoldMessage(context, state.message ?? "Error");
        }
        if(state.status.isSubmissionSuccess){
          _comment.clear();
        }
      },
      child: SafeArea(
        child: Column(
          children: [
            _commentList(),
            _commentForm(context)
          ],
        ),
      ),
    );
  }

  Widget _commentList(){
    return Expanded(
      child: BlocBuilder<CommentBloc, CommentState>(
        builder: (context, state){
          if(state.comments == <CommentModel>[] || state.comments.isEmpty){
            return Center(
              child: Text("No Comment"),
            );
          }
          if(state.comments != <CommentModel>[]){
            return Container(
              child: ListView.builder(
                itemCount: state.comments.length,
                itemBuilder: (context, index){
                  return _commentListItem(state.comments[index]);
                },
              ),
            );
          }
          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }

  Widget _commentListItem(CommentModel comment){
    return Container(
      child: ListTile(
        leading: _commentImage(comment.user!.picture!.string!),
        title: Text(comment.user!.username!),
        subtitle: Text(comment.komen!),
      ),
    );
  }

  Widget _commentImage(String image){
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

  Widget _commentForm(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Material(
      elevation: 20,
      child: Container(
        width: size.width,
        height: size.height * 0.075,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: "Tambahkan Komentar"
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _comment,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            BlocBuilder<CommentBloc, CommentState>(
              builder: (context, state){
                return state.status.isSubmissionInProgress
                    ? CircularProgressIndicator()
                    : InkWell(
                        onTap: (){
                          if(_comment.text != ""){
                            BlocProvider.of<CommentBloc>(context).add(
                                CreateComment(widget.id, _comment.text)
                            );
                          }
                        },
                        borderRadius: BorderRadius.circular(1000),
                        child: Container(
                          width: size.height * 0.05,
                          height: size.height * 0.05,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.teal
                          ),
                          child: Icon(Icons.send, color: Colors.white,),
                        ),
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}