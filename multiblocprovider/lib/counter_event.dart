part of 'counter_bloc.dart';

@immutable
abstract class CounterEvent {}

class IncrementEvent extends CounterEvent{
  final int number;

  IncrementEvent({this.number = 1});
}

class DecrementEvent extends CounterEvent{}
