import 'package:equatable/equatable.dart';

import '../../domain/entities/checkout_item.dart';

/// States for the Checkout BLoC
/// Using Dart 3 sealed classes for exhaustive pattern matching
sealed class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the bloc is first created
final class CheckoutInitial extends CheckoutState {
  const CheckoutInitial();
}

/// State while loading checkout data
final class CheckoutLoading extends CheckoutState {
  const CheckoutLoading();
}

/// State when items are successfully loaded
final class CheckoutLoaded extends CheckoutState {
  final List<CheckoutItem> items;
  final double totalAmount;

  const CheckoutLoaded({
    required this.items,
    required this.totalAmount,
  });

  /// Check if the cart is empty
  bool get isEmpty => items.isEmpty;

  /// Get the number of items in the cart
  int get itemCount => items.length;

  @override
  List<Object?> get props => [items, totalAmount];
}

/// State when checkout was processed successfully
final class CheckoutSuccess extends CheckoutState {
  final String transactionId;
  final double totalAmount;

  const CheckoutSuccess({
    required this.transactionId,
    required this.totalAmount,
  });

  @override
  List<Object?> get props => [transactionId, totalAmount];
}

/// State when an error occurs
final class CheckoutError extends CheckoutState {
  final String message;
  final String? code;

  const CheckoutError({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];
}
