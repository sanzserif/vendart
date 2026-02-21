import 'package:equatable/equatable.dart';

/// Counter entity - represents a simple counter value
class Counter extends Equatable {
  final int value;

  const Counter({required this.value});

  const Counter.initial() : value = 0;

  Counter increment() => Counter(value: value + 1);

  Counter decrement() => Counter(value: value > 0 ? value - 1 : 0);

  Counter reset() => const Counter(value: 0);

  @override
  List<Object?> get props => [value];
}
