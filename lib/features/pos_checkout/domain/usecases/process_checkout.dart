import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/checkout_repository.dart';

/// Use case for processing a checkout/sale
class ProcessCheckout implements UseCase<String, ProcessCheckoutParams> {
  final CheckoutRepository repository;

  ProcessCheckout(this.repository);

  @override
  Future<String> call(ProcessCheckoutParams params) async {
    final items = await repository.getCheckoutItems();
    return repository.processCheckout(
      items: items,
      paymentMethod: params.paymentMethod,
      amountPaid: params.amountPaid,
    );
  }
}

/// Parameters for the ProcessCheckout use case
class ProcessCheckoutParams extends Equatable {
  final String paymentMethod;
  final double? amountPaid;

  const ProcessCheckoutParams({
    required this.paymentMethod,
    this.amountPaid,
  });

  @override
  List<Object?> get props => [paymentMethod, amountPaid];
}
