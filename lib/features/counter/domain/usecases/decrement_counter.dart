import '../../../../core/usecases/usecase.dart';
import '../entities/counter.dart';
import '../repositories/counter_repository.dart';

/// Use case for decrementing the counter
class DecrementCounter implements UseCase<Counter, Counter> {
  final CounterRepository repository;

  DecrementCounter(this.repository);

  @override
  Future<Counter> call(Counter current) async {
    final newCounter = current.decrement();
    await repository.saveCounter(newCounter);
    return newCounter;
  }
}
