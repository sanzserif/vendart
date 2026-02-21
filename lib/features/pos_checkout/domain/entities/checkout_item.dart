import 'package:equatable/equatable.dart';

/// Represents a checkout item in the POS system
/// This is a domain entity - pure business logic, no UI or database dependencies
class CheckoutItem extends Equatable {
  final String id;
  final String productId;
  final String productName;
  final double unitPrice;
  final int quantity;
  final double? discount;

  const CheckoutItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.unitPrice,
    required this.quantity,
    this.discount,
  });

  /// Calculate the total price for this item
  double get totalPrice {
    final subtotal = unitPrice * quantity;
    if (discount != null && discount! > 0) {
      return subtotal - (subtotal * discount! / 100);
    }
    return subtotal;
  }

  /// Create a copy with updated values
  CheckoutItem copyWith({
    String? id,
    String? productId,
    String? productName,
    double? unitPrice,
    int? quantity,
    double? discount,
  }) {
    return CheckoutItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      unitPrice: unitPrice ?? this.unitPrice,
      quantity: quantity ?? this.quantity,
      discount: discount ?? this.discount,
    );
  }

  @override
  List<Object?> get props =>
      [id, productId, productName, unitPrice, quantity, discount];
}
