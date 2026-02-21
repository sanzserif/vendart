import '../models/checkout_item_model.dart';

/// Local data source for checkout operations
/// This handles all local database/cache operations for the cart
abstract interface class CheckoutLocalDataSource {
  /// Get all items from local storage
  Future<List<CheckoutItemModel>> getItems();

  /// Save an item to local storage
  Future<void> saveItem(CheckoutItemModel item);

  /// Update an item in local storage
  Future<void> updateItem(CheckoutItemModel item);

  /// Remove an item from local storage
  Future<void> removeItem(String itemId);

  /// Clear all items from local storage
  Future<void> clearAll();
}

/// Implementation of CheckoutLocalDataSource
/// TODO: Implement with Drift database
class CheckoutLocalDataSourceImpl implements CheckoutLocalDataSource {
  // In-memory storage for now - replace with Drift
  final List<CheckoutItemModel> _items = [];

  @override
  Future<List<CheckoutItemModel>> getItems() async {
    return List.unmodifiable(_items);
  }

  @override
  Future<void> saveItem(CheckoutItemModel item) async {
    _items.add(item);
  }

  @override
  Future<void> updateItem(CheckoutItemModel item) async {
    final index = _items.indexWhere((i) => i.id == item.id);
    if (index != -1) {
      _items[index] = item;
    }
  }

  @override
  Future<void> removeItem(String itemId) async {
    _items.removeWhere((item) => item.id == itemId);
  }

  @override
  Future<void> clearAll() async {
    _items.clear();
  }
}
