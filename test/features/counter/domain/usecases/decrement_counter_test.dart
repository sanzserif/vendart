import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vendart/features/counter/domain/entities/counter.dart';
import 'package:vendart/features/counter/domain/repositories/counter_repository.dart';
import 'package:vendart/features/counter/domain/usecases/decrement_counter.dart';

class MockCounterRepository extends Mock implements CounterRepository {}

void main() {
  late DecrementCounter useCase;
  late MockCounterRepository mockRepository;

  setUp(() {
    mockRepository = MockCounterRepository();
    useCase = DecrementCounter(mockRepository);
  });

  group('DecrementCounter', () {
    const tCounter = Counter(value: 5);
    const tDecrementedCounter = Counter(value: 4);

    test('should decrement counter and save to repository', () async {
      // arrange
      when(() => mockRepository.saveCounter(tDecrementedCounter))
          .thenAnswer((_) async {});

      // act
      final result = await useCase(tCounter);

      // assert
      expect(result, tDecrementedCounter);
      verify(() => mockRepository.saveCounter(tDecrementedCounter)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should not decrement below 0', () async {
      // arrange
      const zeroCounter = Counter(value: 0);
      when(() => mockRepository.saveCounter(zeroCounter))
          .thenAnswer((_) async {});

      // act
      final result = await useCase(zeroCounter);

      // assert
      expect(result.value, 0);
    });
  });
}
