import 'package:flutter_bloc/flutter_bloc.dart';

class ObscureCubit extends Cubit<bool>{
  ObscureCubit() : super(true);

  void changeStatus(){
    emit(!state);
  }
}