import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Cubit<Map<String,dynamic>>{
  UserBloc() : super({"name" : "", "age" : 0});

  void changeName(String name){
    emit({
      "name" : name,
      "age" : state["age"]
    });
  }

  void changeAge(int age){
    emit({
      "name" : state["name"],
      "age" : age
    });
  }
}