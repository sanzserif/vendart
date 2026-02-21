import '../entities/checkout_item.dart';

/// Abstract repository interface for POS checkout operations
/// This interface lives in the domain layer and defines the contract
/// that the data layer must implement
abstract interface class CheckoutRepository {
  /// Get all items currently in the checkout cart
  Future<List<CheckoutItem>> getCheckoutItems();

  /// Add an item to the checkout cart
  Future<void> addItem(CheckoutItem item);

  /// Update an existing item in the cart
  Future<void> updateItem(CheckoutItem item);

  /// Remove an item from the cart by its ID
  Future<void> removeItem(String itemId);

  /// Clear all items from the cart
  Future<void> clearCart();

  /// Calculate the total amount for all items in the cart
  Future<double> calculateTotal();

  /// Process the checkout and complete the sale
  /// Returns the transaction ID on success
  Future<String> processCheckout({
    required List<CheckoutItem> items,
    required String paymentMethod,
    double? amountPaid,
  });
}
