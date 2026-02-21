import 'package:equatable/equatable.dart';

import '../../domain/entities/counter.dart';

/// States for the Counter BLoC
/// Using Dart 3 sealed classes for exhaustive pattern matching
sealed class CounterState extends Equatable {
  const CounterState();

  @override
  List<Object?> get props => [];
}

/// Initial state
final class CounterInitial extends CounterState {
  const CounterInitial();
}

/// State when counter value is loaded/updated
final class CounterLoaded extends CounterState {
  final Counter counter;

  const CounterLoaded(this.counter);

  int get value => counter.value;

  @override
  List<Object?> get props => [counter];
}

/// State when an error occurs
final class CounterError extends CounterState {
  final String message;

  const CounterError(this.message);

  @override
  List<Object?> get props => [message];
}
