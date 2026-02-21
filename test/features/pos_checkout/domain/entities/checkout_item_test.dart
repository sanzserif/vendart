import 'package:flutter_test/flutter_test.dart';
import 'package:vendart/features/pos_checkout/domain/entities/checkout_item.dart';

void main() {
  group('CheckoutItem', () {
    const testItem = CheckoutItem(
      id: '1',
      productId: 'prod-001',
      productName: 'Test Product',
      unitPrice: 25.99,
      quantity: 3,
    );

    test('should create a valid CheckoutItem', () {
      expect(testItem.id, '1');
      expect(testItem.productId, 'prod-001');
      expect(testItem.productName, 'Test Product');
      expect(testItem.unitPrice, 25.99);
      expect(testItem.quantity, 3);
      expect(testItem.discount, isNull);
    });

    test('totalPrice should calculate correctly without discount', () {
      // 25.99 * 3 = 77.97
      expect(testItem.totalPrice, closeTo(77.97, 0.01));
    });

    test('totalPrice should calculate correctly with discount', () {
      const itemWithDiscount = CheckoutItem(
        id: '2',
        productId: 'prod-002',
        productName: 'Discounted Product',
        unitPrice: 100.0,
        quantity: 2,
        discount: 10.0, // 10% discount
      );

      // (100 * 2) - (200 * 10%) = 200 - 20 = 180
      expect(itemWithDiscount.totalPrice, 180.0);
    });

    test('copyWith should create a copy with updated values', () {
      final updatedItem = testItem.copyWith(quantity: 5);

      expect(updatedItem.id, testItem.id);
      expect(updatedItem.productId, testItem.productId);
      expect(updatedItem.productName, testItem.productName);
      expect(updatedItem.unitPrice, testItem.unitPrice);
      expect(updatedItem.quantity, 5);
    });

    test('copyWith should preserve original values when not specified', () {
      final copiedItem = testItem.copyWith();

      expect(copiedItem.id, testItem.id);
      expect(copiedItem.productId, testItem.productId);
      expect(copiedItem.productName, testItem.productName);
      expect(copiedItem.unitPrice, testItem.unitPrice);
      expect(copiedItem.quantity, testItem.quantity);
    });

    test('props should include all fields for Equatable', () {
      expect(
        testItem.props,
        [
          testItem.id,
          testItem.productId,
          testItem.productName,
          testItem.unitPrice,
          testItem.quantity,
          testItem.discount,
        ],
      );
    });

    test('two items with same props should be equal', () {
      const item1 = CheckoutItem(
        id: '1',
        productId: 'p1',
        productName: 'Product',
        unitPrice: 10.0,
        quantity: 1,
      );

      const item2 = CheckoutItem(
        id: '1',
        productId: 'p1',
        productName: 'Product',
        unitPrice: 10.0,
        quantity: 1,
      );

      expect(item1, equals(item2));
    });
  });
}
