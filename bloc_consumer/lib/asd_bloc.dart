import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'asd_event.dart';
part 'asd_state.dart';

class AsdBloc extends Bloc<AsdEvent, AsdState> {
  AsdBloc() : super(AsdInitial()) {
    on<AsdEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
