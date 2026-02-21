import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/checkout_item.dart';
import '../bloc/checkout_bloc.dart';
import '../bloc/checkout_event.dart';

/// Widget to display a single checkout item in the list
class CheckoutItemTile extends StatelessWidget {
  final CheckoutItem item;

  const CheckoutItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Product info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productName,
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${item.unitPrice.toStringAsFixed(2)} each',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            // Quantity controls
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: item.quantity > 1
                      ? () {
                          context.read<CheckoutBloc>().add(
                                UpdateItemQuantity(
                                  itemId: item.id,
                                  newQuantity: item.quantity - 1,
                                ),
                              );
                        }
                      : null,
                ),
                Text(
                  '${item.quantity}',
                  style: theme.textTheme.titleMedium,
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {
                    context.read<CheckoutBloc>().add(
                          UpdateItemQuantity(
                            itemId: item.id,
                            newQuantity: item.quantity + 1,
                          ),
                        );
                  },
                ),
              ],
            ),

            // Total price
            SizedBox(
              width: 80,
              child: Text(
                '\$${item.totalPrice.toStringAsFixed(2)}',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
            ),

            // Remove button
            IconButton(
              icon: const Icon(Icons.delete_outline),
              color: theme.colorScheme.error,
              onPressed: () {
                context.read<CheckoutBloc>().add(RemoveItemRequested(item.id));
              },
            ),
          ],
        ),
      ),
    );
  }
}
