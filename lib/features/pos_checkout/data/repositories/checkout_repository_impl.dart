import '../../domain/entities/checkout_item.dart';
import '../../domain/repositories/checkout_repository.dart';
import '../datasources/checkout_local_datasource.dart';
import '../models/checkout_item_model.dart';

/// Implementation of the CheckoutRepository interface
/// This class lives in the data layer and coordinates between
/// data sources and the domain layer
class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutLocalDataSource localDataSource;

  CheckoutRepositoryImpl({required this.localDataSource});

  @override
  Future<List<CheckoutItem>> getCheckoutItems() async {
    return localDataSource.getItems();
  }

  @override
  Future<void> addItem(CheckoutItem item) async {
    final model = CheckoutItemModel.fromEntity(item);
    await localDataSource.saveItem(model);
  }

  @override
  Future<void> updateItem(CheckoutItem item) async {
    final model = CheckoutItemModel.fromEntity(item);
    await localDataSource.updateItem(model);
  }

  @override
  Future<void> removeItem(String itemId) async {
    await localDataSource.removeItem(itemId);
  }

  @override
  Future<void> clearCart() async {
    await localDataSource.clearAll();
  }

  @override
  Future<double> calculateTotal() async {
    final items = await localDataSource.getItems();
    return items.fold<double>(0.0, (sum, item) => sum + item.totalPrice);
  }

  @override
  Future<String> processCheckout({
    required List<CheckoutItem> items,
    required String paymentMethod,
    double? amountPaid,
  }) async {
    // TODO: Implement actual checkout processing
    // - Save transaction to database
    // - Print receipt
    // - Clear cart
    await clearCart();

    // Return a mock transaction ID
    return 'TXN-${DateTime.now().millisecondsSinceEpoch}';
  }
}
