import 'package:equatable/equatable.dart';

import '../../domain/entities/checkout_item.dart';

/// Events for the Checkout BLoC
/// Using Dart 3 sealed classes for exhaustive pattern matching
sealed class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load all items in the checkout cart
final class LoadCheckoutItems extends CheckoutEvent {
  const LoadCheckoutItems();
}

/// Event to add a new item to the cart
final class AddItemRequested extends CheckoutEvent {
  final CheckoutItem item;

  const AddItemRequested(this.item);

  @override
  List<Object?> get props => [item];
}

/// Event to update an existing item's quantity
final class UpdateItemQuantity extends CheckoutEvent {
  final String itemId;
  final int newQuantity;

  const UpdateItemQuantity({
    required this.itemId,
    required this.newQuantity,
  });

  @override
  List<Object?> get props => [itemId, newQuantity];
}

/// Event to remove an item from the cart
final class RemoveItemRequested extends CheckoutEvent {
  final String itemId;

  const RemoveItemRequested(this.itemId);

  @override
  List<Object?> get props => [itemId];
}

/// Event to clear all items from the cart
final class ClearCartRequested extends CheckoutEvent {
  const ClearCartRequested();
}

/// Event to process the checkout
final class ProcessCheckoutRequested extends CheckoutEvent {
  final String paymentMethod;
  final double? amountPaid;

  const ProcessCheckoutRequested({
    required this.paymentMethod,
    this.amountPaid,
  });

  @override
  List<Object?> get props => [paymentMethod, amountPaid];
}
