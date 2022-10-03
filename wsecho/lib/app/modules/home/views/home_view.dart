import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: controller.controller,
              ),
            ),
            SizedBox(height: 24),
            StreamBuilder(
                stream: controller.channel.stream,
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.active){
                    var data = snapshot.data;
                    return Text(
                        snapshot.hasData
                            ? "${data}"
                            : ""
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            controller.sendMessage();
          }
      ),
    );
  }
}
