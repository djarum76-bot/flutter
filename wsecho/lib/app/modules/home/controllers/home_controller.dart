import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';

class HomeController extends GetxController {
  final TextEditingController controller = TextEditingController();
  final channel = IOWebSocketChannel.connect(
    Uri.parse('ws://192.168.1.211:1323/stream'),
  );

  void sendMessage(){
    if(controller.text.isNotEmpty){
      channel.sink.add(controller.text);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    channel.sink.close();
    controller.dispose();
    super.dispose();
  }
}
