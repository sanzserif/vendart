import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/counter.dart';
import '../../domain/repositories/counter_repository.dart';
import '../../domain/usecases/decrement_counter.dart';
import '../../domain/usecases/increment_counter.dart';
import 'counter_event.dart';
import 'counter_state.dart';

/// BLoC for managing counter state
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final IncrementCounter incrementCounter;
  final DecrementCounter decrementCounter;
  final CounterRepository repository;

  CounterBloc({
    required this.incrementCounter,
    required this.decrementCounter,
    required this.repository,
  }) : super(const CounterInitial()) {
    on<CounterStarted>(_onStarted);
    on<CounterIncremented>(_onIncremented);
    on<CounterDecremented>(_onDecremented);
    on<CounterReset>(_onReset);
  }

  Future<void> _onStarted(
    CounterStarted event,
    Emitter<CounterState> emit,
  ) async {
    final counter = await repository.getCounter();
    emit(CounterLoaded(counter));
  }

  Future<void> _onIncremented(
    CounterIncremented event,
    Emitter<CounterState> emit,
  ) async {
    final currentState = state;
    if (currentState is CounterLoaded) {
      try {
        final newCounter = await incrementCounter(currentState.counter);
        emit(CounterLoaded(newCounter));
      } catch (e) {
        emit(CounterError(e.toString()));
      }
    }
  }

  Future<void> _onDecremented(
    CounterDecremented event,
    Emitter<CounterState> emit,
  ) async {
    final currentState = state;
    if (currentState is CounterLoaded) {
      try {
        final newCounter = await decrementCounter(currentState.counter);
        emit(CounterLoaded(newCounter));
      } catch (e) {
        emit(CounterError(e.toString()));
      }
    }
  }

  Future<void> _onReset(
    CounterReset event,
    Emitter<CounterState> emit,
  ) async {
    try {
      await repository.resetCounter();
      emit(const CounterLoaded(Counter.initial()));
    } catch (e) {
      emit(CounterError(e.toString()));
    }
  }
}
