import 'package:chatgpt/bloc/chat/chat_bloc.dart';
import 'package:chatgpt/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChatScreen extends StatefulWidget{
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController _chat;
  late ScrollController _scroll;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chat = TextEditingController();
    _scroll = ScrollController();
    _latestChat();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _chat.dispose();
    _scroll.dispose();
  }

  void _latestChat(){
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 500), (){
        _scroll.jumpTo(_scroll.position.maxScrollExtent);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _chatBody(context),
    );
  }

  Widget _chatBody(BuildContext context){
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state){
        if(state.status == ChatStatus.loading){
          _chat.clear();
          _latestChat();
        }

        if(state.status == ChatStatus.success){
          _latestChat();
        }

        if(state.status == ChatStatus.error){
          EasyLoading.showError("Cannot get what you want, sorry:(");
        }
      },
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              _chatData(),
              _chatFormSendButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _chatData(){
    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(1.h, 1.h, 1.h, 0),
        child: SingleChildScrollView(
          controller: _scroll,
          child: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state){
              return Column(
                children: _itemChatList(state),
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _itemChatList(ChatState state){
    List<Widget> list = <Widget>[];

    if(state.chats == null){
      for(int i = 0; i < 0; i++){
        list.add(_itemChat(chat: state.chats![i], index: i));
      }
    }else{
      if(state.status == ChatStatus.loading){
        for(int i = 0; i < state.chats!.length + 1; i++){
          if(i == state.chats!.length){
            list.add(_itemChatLoading());
          }else{
            list.add(_itemChat(chat: state.chats![i], index: i));
          }
        }
      }else{
        for(int i = 0; i < state.chats!.length; i++){
          list.add(_itemChat(chat: state.chats![i], index: i));
        }
      }
    }

    return list;
  }

  Widget _itemChat({required ChatModel chat, required int index}){
    return InkWell(
      onLongPress: () async {
        await Clipboard.setData(ClipboardData(text: chat.chat!)).then((_){
          EasyLoading.showSuccess('Copied to your clipboard');
        });
      },
      borderRadius: BorderRadius.only(
        topRight: chat.isSender! ? Radius.zero : const Radius.circular(16),
        topLeft: chat.isSender! ? const Radius.circular(16) : Radius.zero,
        bottomRight: const Radius.circular(16),
        bottomLeft: const Radius.circular(16),
      ),
      child: Align(
        alignment: chat.isSender! ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.only(top: index == 0 ? 0 : 1.h),
          padding: EdgeInsets.all(1.5.h),
          decoration: BoxDecoration(
              color: chat.isSender! ? Colors.blue : const Color(0xFF202c33),
              borderRadius: BorderRadius.only(
                topRight: chat.isSender! ? Radius.zero : const Radius.circular(16),
                topLeft: chat.isSender! ? const Radius.circular(16) : Radius.zero,
                bottomRight: const Radius.circular(16),
                bottomLeft: const Radius.circular(16),
              )
          ),
          child: Text(
            chat.chat!,
            style: GoogleFonts.urbanist(color:  Colors.white, fontSize: 16.sp),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }

  Widget _itemChatLoading(){
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(top: 1.h),
        padding: EdgeInsets.all(1.5.h),
        decoration: const BoxDecoration(
            color: Color(0xFF202c33),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.zero,
              bottomRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            )
        ),
        child: const CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }

  Widget _chatFormSendButton(BuildContext context){
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.all(1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _chatForm(),
          SizedBox(width: 2.w,),
          _chatSendButton(context)
        ],
      ),
    );
  }

  Widget _chatForm(){
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            hintText: "Ketik Pesan",
            contentPadding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h)
        ),
        controller: _chat,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        textCapitalization: TextCapitalization.sentences,
      ),
    );
  }

  Widget _chatSendButton(BuildContext context){
    return InkWell(
      onTap: (){
        if(_chat.text != ""){
          ChatModel chat = ChatModel(chat: _chat.text, isSender: true);
          BlocProvider.of<ChatBloc>(context).add(CreateCompletion(chat));
        }
      },
      borderRadius: BorderRadius.circular(200),
      child: Container(
        width: 10.w,
        height: 10.w,
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue
        ),
        child: Center(
          child: Icon(Icons.send, color: Colors.white, size: 5.w,),
        ),
      ),
    );
  }
}