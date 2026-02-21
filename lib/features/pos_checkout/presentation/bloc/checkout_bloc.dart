import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/add_item_to_cart.dart';
import '../../domain/usecases/get_checkout_items.dart';
import '../../domain/usecases/process_checkout.dart';
import '../../domain/repositories/checkout_repository.dart';
import 'checkout_event.dart';
import 'checkout_state.dart';

/// BLoC for managing the POS checkout process
class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final GetCheckoutItems getCheckoutItems;
  final AddItemToCart addItemToCart;
  final ProcessCheckout processCheckout;
  final CheckoutRepository repository;

  CheckoutBloc({
    required this.getCheckoutItems,
    required this.addItemToCart,
    required this.processCheckout,
    required this.repository,
  }) : super(const CheckoutInitial()) {
    on<LoadCheckoutItems>(_onLoadCheckoutItems);
    on<AddItemRequested>(_onAddItemRequested);
    on<UpdateItemQuantity>(_onUpdateItemQuantity);
    on<RemoveItemRequested>(_onRemoveItemRequested);
    on<ClearCartRequested>(_onClearCartRequested);
    on<ProcessCheckoutRequested>(_onProcessCheckoutRequested);
  }

  Future<void> _onLoadCheckoutItems(
    LoadCheckoutItems event,
    Emitter<CheckoutState> emit,
  ) async {
    emit(const CheckoutLoading());
    try {
      final items = await getCheckoutItems();
      final total = await repository.calculateTotal();
      emit(CheckoutLoaded(items: items, totalAmount: total));
    } catch (e) {
      emit(CheckoutError(message: e.toString()));
    }
  }

  Future<void> _onAddItemRequested(
    AddItemRequested event,
    Emitter<CheckoutState> emit,
  ) async {
    try {
      await addItemToCart(event.item);
      add(const LoadCheckoutItems());
    } catch (e) {
      emit(CheckoutError(message: e.toString()));
    }
  }

  Future<void> _onUpdateItemQuantity(
    UpdateItemQuantity event,
    Emitter<CheckoutState> emit,
  ) async {
    final currentState = state;
    if (currentState is! CheckoutLoaded) return;

    try {
      final item = currentState.items.firstWhere((i) => i.id == event.itemId);
      final updatedItem = item.copyWith(quantity: event.newQuantity);
      await repository.updateItem(updatedItem);
      add(const LoadCheckoutItems());
    } catch (e) {
      emit(CheckoutError(message: e.toString()));
    }
  }

  Future<void> _onRemoveItemRequested(
    RemoveItemRequested event,
    Emitter<CheckoutState> emit,
  ) async {
    try {
      await repository.removeItem(event.itemId);
      add(const LoadCheckoutItems());
    } catch (e) {
      emit(CheckoutError(message: e.toString()));
    }
  }

  Future<void> _onClearCartRequested(
    ClearCartRequested event,
    Emitter<CheckoutState> emit,
  ) async {
    try {
      await repository.clearCart();
      emit(const CheckoutLoaded(items: [], totalAmount: 0));
    } catch (e) {
      emit(CheckoutError(message: e.toString()));
    }
  }

  Future<void> _onProcessCheckoutRequested(
    ProcessCheckoutRequested event,
    Emitter<CheckoutState> emit,
  ) async {
    final currentState = state;
    if (currentState is! CheckoutLoaded) return;

    emit(const CheckoutLoading());
    try {
      final transactionId = await processCheckout(
        ProcessCheckoutParams(
          paymentMethod: event.paymentMethod,
          amountPaid: event.amountPaid,
        ),
      );
      emit(CheckoutSuccess(
        transactionId: transactionId,
        totalAmount: currentState.totalAmount,
      ));
    } catch (e) {
      emit(CheckoutError(message: e.toString()));
    }
  }
}
