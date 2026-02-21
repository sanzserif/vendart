import 'package:flutter_test/flutter_test.dart';
import 'package:vendart/features/counter/domain/entities/counter.dart';

void main() {
  group('Counter', () {
    test('should create a Counter with the given value', () {
      const counter = Counter(value: 5);
      expect(counter.value, 5);
    });

    test('Counter.initial() should create a counter with value 0', () {
      const counter = Counter.initial();
      expect(counter.value, 0);
    });

    test('increment should increase value by 1', () {
      const counter = Counter(value: 5);
      final incremented = counter.increment();
      expect(incremented.value, 6);
    });

    test('decrement should decrease value by 1', () {
      const counter = Counter(value: 5);
      final decremented = counter.decrement();
      expect(decremented.value, 4);
    });

    test('decrement should not go below 0', () {
      const counter = Counter(value: 0);
      final decremented = counter.decrement();
      expect(decremented.value, 0);
    });

    test('reset should return a counter with value 0', () {
      const counter = Counter(value: 10);
      final resetCounter = counter.reset();
      expect(resetCounter.value, 0);
    });

    test('two counters with same value should be equal', () {
      const counter1 = Counter(value: 5);
      const counter2 = Counter(value: 5);
      expect(counter1, equals(counter2));
    });

    test('two counters with different values should not be equal', () {
      const counter1 = Counter(value: 5);
      const counter2 = Counter(value: 10);
      expect(counter1, isNot(equals(counter2)));
    });
  });
}
