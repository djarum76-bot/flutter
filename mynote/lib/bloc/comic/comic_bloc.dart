import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'comic_event.dart';
part 'comic_state.dart';

class ComicBloc extends Bloc<ComicEvent, ComicState> {
  ComicBloc() : super(ComicInitial()) {
    on<ComicEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
