import '../../domain/entities/checkout_item.dart';

/// Data model for CheckoutItem - handles serialization/deserialization
/// This model is part of the data layer and converts between
/// database/API formats and domain entities
class CheckoutItemModel extends CheckoutItem {
  const CheckoutItemModel({
    required super.id,
    required super.productId,
    required super.productName,
    required super.unitPrice,
    required super.quantity,
    super.discount,
  });

  /// Create a model from JSON (API response or cache)
  factory CheckoutItemModel.fromJson(Map<String, dynamic> json) {
    return CheckoutItemModel(
      id: json['id'] as String,
      productId: json['product_id'] as String,
      productName: json['product_name'] as String,
      unitPrice: (json['unit_price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      discount: json['discount'] != null
          ? (json['discount'] as num).toDouble()
          : null,
    );
  }

  /// Convert the model to JSON for storage or API calls
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'product_name': productName,
      'unit_price': unitPrice,
      'quantity': quantity,
      'discount': discount,
    };
  }

  /// Create a model from a domain entity
  factory CheckoutItemModel.fromEntity(CheckoutItem entity) {
    return CheckoutItemModel(
      id: entity.id,
      productId: entity.productId,
      productName: entity.productName,
      unitPrice: entity.unitPrice,
      quantity: entity.quantity,
      discount: entity.discount,
    );
  }
}
