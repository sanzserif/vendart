import '../../../../core/usecases/usecase.dart';
import '../entities/checkout_item.dart';
import '../repositories/checkout_repository.dart';

/// Use case for adding an item to the checkout cart
class AddItemToCart implements UseCase<void, CheckoutItem> {
  final CheckoutRepository repository;

  AddItemToCart(this.repository);

  @override
  Future<void> call(CheckoutItem item) async {
    return repository.addItem(item);
  }
}
