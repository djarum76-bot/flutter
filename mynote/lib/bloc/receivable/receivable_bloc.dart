import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'receivable_event.dart';
part 'receivable_state.dart';

class ReceivableBloc extends Bloc<ReceivableEvent, ReceivableState> {
  ReceivableBloc() : super(ReceivableInitial()) {
    on<ReceivableEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
