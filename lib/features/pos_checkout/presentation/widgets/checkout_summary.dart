import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/checkout_bloc.dart';
import '../bloc/checkout_event.dart';

/// Widget showing the checkout summary and payment options
class CheckoutSummary extends StatelessWidget {
  final double totalAmount;
  final int itemCount;

  const CheckoutSummary({
    super.key,
    required this.totalAmount,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Summary row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$itemCount items',
                  style: theme.textTheme.bodyLarge,
                ),
                Text(
                  'Total: \$${totalAmount.toStringAsFixed(2)}',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Payment buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _processPayment(context, 'cash'),
                    icon: const Icon(Icons.money),
                    label: const Text('Cash'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => _processPayment(context, 'card'),
                    icon: const Icon(Icons.credit_card),
                    label: const Text('Card'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _processPayment(BuildContext context, String method) {
    context.read<CheckoutBloc>().add(
          ProcessCheckoutRequested(
            paymentMethod: method,
            amountPaid: totalAmount,
          ),
        );
  }
}
