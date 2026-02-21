import '../../domain/entities/counter.dart';
import '../../domain/repositories/counter_repository.dart';

/// In-memory implementation of CounterRepository
/// In a real app, this would use Drift/SQLite for persistence
class CounterRepositoryImpl implements CounterRepository {
  Counter _counter = const Counter.initial();

  @override
  Future<Counter> getCounter() async {
    return _counter;
  }

  @override
  Future<void> saveCounter(Counter counter) async {
    _counter = counter;
  }

  @override
  Future<void> resetCounter() async {
    _counter = const Counter.initial();
  }
}
