import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuldiiblocselector/bloc/user_bloc.dart';

class Home extends StatelessWidget{
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserBloc user = context.read<UserBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          BlocSelector<UserBloc, Map<String,dynamic>, String>(
              selector: (state) => state["name"],
              builder: (context, state){
                return Text("NAMA : $state");
              }
          ),
          BlocSelector<UserBloc, Map<String,dynamic>, int>(
              selector: (state) => state["age"],
              builder: (context, state){
                return Text("UMUR : $state");
              }
          ),
          SizedBox(height: 20,),
          TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "NAMA"
            ),
            controller: name,
            onChanged: (val){
              user.changeName(val);
            },
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: (){
                    user.changeAge(user.state["age"]-1);
                  },
                  icon: Icon(Icons.remove)
              ),
              IconButton(
                  onPressed: (){
                    user.changeAge(user.state["age"]+1);
                  },
                  icon: Icon(Icons.add)
              )
            ],
          )
        ],
      ),
    );
  }
}