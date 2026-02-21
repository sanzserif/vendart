import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vendart/features/counter/domain/entities/counter.dart';
import 'package:vendart/features/counter/domain/repositories/counter_repository.dart';
import 'package:vendart/features/counter/domain/usecases/decrement_counter.dart';
import 'package:vendart/features/counter/domain/usecases/increment_counter.dart';
import 'package:vendart/features/counter/presentation/bloc/counter_bloc.dart';
import 'package:vendart/features/counter/presentation/bloc/counter_event.dart';
import 'package:vendart/features/counter/presentation/bloc/counter_state.dart';

// Mock classes
class MockIncrementCounter extends Mock implements IncrementCounter {}

class MockDecrementCounter extends Mock implements DecrementCounter {}

class MockCounterRepository extends Mock implements CounterRepository {}

void main() {
  late CounterBloc bloc;
  late MockIncrementCounter mockIncrementCounter;
  late MockDecrementCounter mockDecrementCounter;
  late MockCounterRepository mockRepository;

  setUp(() {
    mockIncrementCounter = MockIncrementCounter();
    mockDecrementCounter = MockDecrementCounter();
    mockRepository = MockCounterRepository();
  });

  CounterBloc buildBloc() {
    return CounterBloc(
      incrementCounter: mockIncrementCounter,
      decrementCounter: mockDecrementCounter,
      repository: mockRepository,
    );
  }

  group('CounterBloc', () {
    test('initial state is CounterInitial', () {
      bloc = buildBloc();
      expect(bloc.state, isA<CounterInitial>());
      bloc.close();
    });

    group('CounterStarted', () {
      blocTest<CounterBloc, CounterState>(
        'emits [CounterLoaded] when CounterStarted is added',
        setUp: () {
          when(() => mockRepository.getCounter())
              .thenAnswer((_) async => const Counter.initial());
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const CounterStarted()),
        expect: () => [
          const CounterLoaded(Counter.initial()),
        ],
        verify: (_) {
          verify(() => mockRepository.getCounter()).called(1);
        },
      );
    });

    group('CounterIncremented', () {
      const tCounter = Counter(value: 0);
      const tIncrementedCounter = Counter(value: 1);

      blocTest<CounterBloc, CounterState>(
        'emits [CounterLoaded] with incremented value when CounterIncremented is added',
        setUp: () {
          when(() => mockIncrementCounter(tCounter))
              .thenAnswer((_) async => tIncrementedCounter);
        },
        build: buildBloc,
        seed: () => const CounterLoaded(tCounter),
        act: (bloc) => bloc.add(const CounterIncremented()),
        expect: () => [
          const CounterLoaded(tIncrementedCounter),
        ],
        verify: (_) {
          verify(() => mockIncrementCounter(tCounter)).called(1);
        },
      );

      blocTest<CounterBloc, CounterState>(
        'emits [CounterError] when increment fails',
        setUp: () {
          when(() => mockIncrementCounter(tCounter))
              .thenThrow(Exception('Increment failed'));
        },
        build: buildBloc,
        seed: () => const CounterLoaded(tCounter),
        act: (bloc) => bloc.add(const CounterIncremented()),
        expect: () => [
          isA<CounterError>(),
        ],
      );
    });

    group('CounterDecremented', () {
      const tCounter = Counter(value: 5);
      const tDecrementedCounter = Counter(value: 4);

      blocTest<CounterBloc, CounterState>(
        'emits [CounterLoaded] with decremented value when CounterDecremented is added',
        setUp: () {
          when(() => mockDecrementCounter(tCounter))
              .thenAnswer((_) async => tDecrementedCounter);
        },
        build: buildBloc,
        seed: () => const CounterLoaded(tCounter),
        act: (bloc) => bloc.add(const CounterDecremented()),
        expect: () => [
          const CounterLoaded(tDecrementedCounter),
        ],
        verify: (_) {
          verify(() => mockDecrementCounter(tCounter)).called(1);
        },
      );
    });

    group('CounterReset', () {
      blocTest<CounterBloc, CounterState>(
        'emits [CounterLoaded] with initial counter when CounterReset is added',
        setUp: () {
          when(() => mockRepository.resetCounter()).thenAnswer((_) async {});
        },
        build: buildBloc,
        seed: () => const CounterLoaded(Counter(value: 10)),
        act: (bloc) => bloc.add(const CounterReset()),
        expect: () => [
          const CounterLoaded(Counter.initial()),
        ],
        verify: (_) {
          verify(() => mockRepository.resetCounter()).called(1);
        },
      );
    });
  });

  group('CounterState', () {
    test('CounterLoaded.value returns the counter value', () {
      const state = CounterLoaded(Counter(value: 42));
      expect(state.value, 42);
    });

    test('CounterLoaded supports equality', () {
      const state1 = CounterLoaded(Counter(value: 5));
      const state2 = CounterLoaded(Counter(value: 5));
      expect(state1, equals(state2));
    });

    test('CounterError contains message', () {
      const state = CounterError('Something went wrong');
      expect(state.message, 'Something went wrong');
    });
  });

  group('CounterEvent', () {
    test('CounterIncremented supports equality', () {
      expect(const CounterIncremented(), equals(const CounterIncremented()));
    });

    test('CounterDecremented supports equality', () {
      expect(const CounterDecremented(), equals(const CounterDecremented()));
    });

    test('CounterReset supports equality', () {
      expect(const CounterReset(), equals(const CounterReset()));
    });
  });
}
