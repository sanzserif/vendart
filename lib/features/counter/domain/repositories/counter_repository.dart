import '../entities/counter.dart';

/// Abstract repository interface for counter operations
abstract interface class CounterRepository {
  /// Get the current counter value
  Future<Counter> getCounter();

  /// Save the counter value
  Future<void> saveCounter(Counter counter);

  /// Reset the counter
  Future<void> resetCounter();
}
