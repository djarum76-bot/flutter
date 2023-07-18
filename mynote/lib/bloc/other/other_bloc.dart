import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'other_event.dart';
part 'other_state.dart';

class OtherBloc extends Bloc<OtherEvent, OtherState> {
  OtherBloc() : super(OtherInitial()) {
    on<OtherEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
