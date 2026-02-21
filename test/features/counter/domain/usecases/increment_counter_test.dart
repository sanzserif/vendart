import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vendart/features/counter/domain/entities/counter.dart';
import 'package:vendart/features/counter/domain/repositories/counter_repository.dart';
import 'package:vendart/features/counter/domain/usecases/increment_counter.dart';

class MockCounterRepository extends Mock implements CounterRepository {}

void main() {
  late IncrementCounter useCase;
  late MockCounterRepository mockRepository;

  setUp(() {
    mockRepository = MockCounterRepository();
    useCase = IncrementCounter(mockRepository);
  });

  group('IncrementCounter', () {
    const tCounter = Counter(value: 5);
    const tIncrementedCounter = Counter(value: 6);

    test('should increment counter and save to repository', () async {
      // arrange
      when(() => mockRepository.saveCounter(tIncrementedCounter))
          .thenAnswer((_) async {});

      // act
      final result = await useCase(tCounter);

      // assert
      expect(result, tIncrementedCounter);
      verify(() => mockRepository.saveCounter(tIncrementedCounter)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should increment counter from 0 to 1', () async {
      // arrange
      const initialCounter = Counter.initial();
      const expectedCounter = Counter(value: 1);
      when(() => mockRepository.saveCounter(expectedCounter))
          .thenAnswer((_) async {});

      // act
      final result = await useCase(initialCounter);

      // assert
      expect(result.value, 1);
    });
  });
}
