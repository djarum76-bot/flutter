import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'debt_event.dart';
part 'debt_state.dart';

class DebtBloc extends Bloc<DebtEvent, DebtState> {
  DebtBloc() : super(DebtInitial()) {
    on<DebtEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
