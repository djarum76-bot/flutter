import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial()) {
    on<IncrementEvent>((event, emit) {
        emit(state is CounterLoaded
            ? CounterLoaded(state.number + event.number)
            : CounterLoaded(event.number)
        );
    });

    on<DecrementEvent>((event, emit) {
      emit(state is CounterLoaded
          ? CounterLoaded(state.number - 1)
          : CounterLoaded(-1)
      );
    });
  }
}
