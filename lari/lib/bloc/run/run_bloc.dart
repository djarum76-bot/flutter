import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'run_event.dart';
part 'run_state.dart';

class RunBloc extends Bloc<RunEvent, RunState> {
  RunBloc() : super(RunInitial()) {
    on<RunEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
