part of 'counter_bloc.dart';

@immutable
abstract class CounterState {
  final int number;

  const CounterState(this.number);
}

class CounterInitial extends CounterState {
  CounterInitial() : super(0);
}

class CounterLoaded extends CounterState{
  CounterLoaded(int number) : super(number);
}
