import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:vendart/features/pos_checkout/domain/entities/checkout_item.dart';
import 'package:vendart/features/pos_checkout/domain/repositories/checkout_repository.dart';
import 'package:vendart/features/pos_checkout/domain/usecases/add_item_to_cart.dart';
import 'package:vendart/features/pos_checkout/domain/usecases/get_checkout_items.dart';
import 'package:vendart/features/pos_checkout/domain/usecases/process_checkout.dart';
import 'package:vendart/features/pos_checkout/presentation/bloc/checkout_bloc.dart';
import 'package:vendart/features/pos_checkout/presentation/bloc/checkout_event.dart';
import 'package:vendart/features/pos_checkout/presentation/bloc/checkout_state.dart';

// Mock classes
class MockGetCheckoutItems extends Mock implements GetCheckoutItems {}

class MockAddItemToCart extends Mock implements AddItemToCart {}

class MockProcessCheckout extends Mock implements ProcessCheckout {}

class MockCheckoutRepository extends Mock implements CheckoutRepository {}

void main() {
  late CheckoutBloc bloc;
  late MockGetCheckoutItems mockGetCheckoutItems;
  late MockAddItemToCart mockAddItemToCart;
  late MockProcessCheckout mockProcessCheckout;
  late MockCheckoutRepository mockRepository;

  setUp(() {
    mockGetCheckoutItems = MockGetCheckoutItems();
    mockAddItemToCart = MockAddItemToCart();
    mockProcessCheckout = MockProcessCheckout();
    mockRepository = MockCheckoutRepository();

    bloc = CheckoutBloc(
      getCheckoutItems: mockGetCheckoutItems,
      addItemToCart: mockAddItemToCart,
      processCheckout: mockProcessCheckout,
      repository: mockRepository,
    );
  });

  tearDown(() {
    bloc.close();
  });

  group('CheckoutBloc', () {
    const testItem = CheckoutItem(
      id: '1',
      productId: 'prod-1',
      productName: 'Test Product',
      unitPrice: 10.99,
      quantity: 2,
    );

    test('initial state is CheckoutInitial', () {
      expect(bloc.state, equals(const CheckoutInitial()));
    });

    group('LoadCheckoutItems', () {
      blocTest<CheckoutBloc, CheckoutState>(
        'emits [CheckoutLoading, CheckoutLoaded] when items are loaded successfully',
        build: () {
          when(() => mockGetCheckoutItems()).thenAnswer(
            (_) async => [testItem],
          );
          when(() => mockRepository.calculateTotal()).thenAnswer(
            (_) async => 21.98,
          );
          return bloc;
        },
        act: (bloc) => bloc.add(const LoadCheckoutItems()),
        expect: () => [
          const CheckoutLoading(),
          const CheckoutLoaded(
            items: [testItem],
            totalAmount: 21.98,
          ),
        ],
        verify: (_) {
          verify(() => mockGetCheckoutItems()).called(1);
          verify(() => mockRepository.calculateTotal()).called(1);
        },
      );

      blocTest<CheckoutBloc, CheckoutState>(
        'emits [CheckoutLoading, CheckoutLoaded] with empty list when no items',
        build: () {
          when(() => mockGetCheckoutItems()).thenAnswer(
            (_) async => [],
          );
          when(() => mockRepository.calculateTotal()).thenAnswer(
            (_) async => 0.0,
          );
          return bloc;
        },
        act: (bloc) => bloc.add(const LoadCheckoutItems()),
        expect: () => [
          const CheckoutLoading(),
          const CheckoutLoaded(items: [], totalAmount: 0.0),
        ],
      );

      blocTest<CheckoutBloc, CheckoutState>(
        'emits [CheckoutLoading, CheckoutError] when loading fails',
        build: () {
          when(() => mockGetCheckoutItems()).thenThrow(
            Exception('Failed to load items'),
          );
          return bloc;
        },
        act: (bloc) => bloc.add(const LoadCheckoutItems()),
        expect: () => [
          const CheckoutLoading(),
          isA<CheckoutError>(),
        ],
      );
    });

    group('ClearCartRequested', () {
      blocTest<CheckoutBloc, CheckoutState>(
        'emits [CheckoutLoaded] with empty cart when clear succeeds',
        build: () {
          when(() => mockRepository.clearCart()).thenAnswer(
            (_) async {},
          );
          return bloc;
        },
        act: (bloc) => bloc.add(const ClearCartRequested()),
        expect: () => [
          const CheckoutLoaded(items: [], totalAmount: 0),
        ],
        verify: (_) {
          verify(() => mockRepository.clearCart()).called(1);
        },
      );
    });

    group('ProcessCheckoutRequested', () {
      blocTest<CheckoutBloc, CheckoutState>(
        'emits [CheckoutLoading, CheckoutSuccess] when checkout succeeds',
        build: () {
          when(() => mockProcessCheckout(any())).thenAnswer(
            (_) async => 'TXN-123456',
          );
          return bloc;
        },
        seed: () => const CheckoutLoaded(
          items: [testItem],
          totalAmount: 21.98,
        ),
        act: (bloc) => bloc.add(const ProcessCheckoutRequested(
          paymentMethod: 'card',
          amountPaid: 21.98,
        )),
        expect: () => [
          const CheckoutLoading(),
          const CheckoutSuccess(
            transactionId: 'TXN-123456',
            totalAmount: 21.98,
          ),
        ],
      );
    });
  });

  group('CheckoutState', () {
    test('CheckoutLoaded isEmpty returns true when items is empty', () {
      const state = CheckoutLoaded(items: [], totalAmount: 0);
      expect(state.isEmpty, isTrue);
    });

    test('CheckoutLoaded isEmpty returns false when items exist', () {
      const state = CheckoutLoaded(
        items: [
          CheckoutItem(
            id: '1',
            productId: 'p1',
            productName: 'Test',
            unitPrice: 10.0,
            quantity: 1,
          ),
        ],
        totalAmount: 10.0,
      );
      expect(state.isEmpty, isFalse);
    });
  });
}
