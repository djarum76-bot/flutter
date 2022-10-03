import 'package:flutter_bloc/flutter_bloc.dart';

class Counter extends Cubit<int>{
  Counter() : super(200);

  void increment(){
    emit(state+1);
  }

  void decrement(){
    emit(state-1);
  }

  @override
  void onChange(Change<int> change) {
    // TODO: implement onChange
    super.onChange(change);
  }
}