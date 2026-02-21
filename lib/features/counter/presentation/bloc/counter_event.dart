import 'package:equatable/equatable.dart';

/// Events for the Counter BLoC
sealed class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object?> get props => [];
}

/// Event to increment the counter
final class CounterIncremented extends CounterEvent {
  const CounterIncremented();
}

/// Event to decrement the counter
final class CounterDecremented extends CounterEvent {
  const CounterDecremented();
}

/// Event to reset the counter
final class CounterReset extends CounterEvent {
  const CounterReset();
}

/// Event to load/start the counter
final class CounterStarted extends CounterEvent {
  const CounterStarted();
}
