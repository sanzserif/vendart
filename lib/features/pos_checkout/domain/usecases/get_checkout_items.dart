import '../../../../core/usecases/usecase.dart';
import '../entities/checkout_item.dart';
import '../repositories/checkout_repository.dart';

/// Use case for retrieving all items in the checkout cart
class GetCheckoutItems implements UseCaseNoParams<List<CheckoutItem>> {
  final CheckoutRepository repository;

  GetCheckoutItems(this.repository);

  @override
  Future<List<CheckoutItem>> call() async {
    return repository.getCheckoutItems();
  }
}
