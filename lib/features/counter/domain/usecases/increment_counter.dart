import '../../../../core/usecases/usecase.dart';
import '../entities/counter.dart';
import '../repositories/counter_repository.dart';

/// Use case for incrementing the counter
class IncrementCounter implements UseCase<Counter, Counter> {
  final CounterRepository repository;

  IncrementCounter(this.repository);

  @override
  Future<Counter> call(Counter current) async {
    final newCounter = current.increment();
    await repository.saveCounter(newCounter);
    return newCounter;
  }
}
