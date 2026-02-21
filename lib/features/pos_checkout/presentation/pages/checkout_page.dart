import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/checkout_bloc.dart';
import '../bloc/checkout_event.dart';
import '../bloc/checkout_state.dart';
import '../widgets/checkout_item_tile.dart';
import '../widgets/checkout_summary.dart';

/// Main page for the POS checkout feature
class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () {
              context.read<CheckoutBloc>().add(const ClearCartRequested());
            },
            tooltip: 'Clear Cart',
          ),
        ],
      ),
      body: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          return switch (state) {
            CheckoutInitial() => const Center(
                child: Text('Start adding items to checkout'),
              ),
            CheckoutLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            CheckoutLoaded(:final items, :final totalAmount) => items.isEmpty
                ? const Center(child: Text('Cart is empty'))
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return CheckoutItemTile(item: items[index]);
                          },
                        ),
                      ),
                      CheckoutSummary(
                        totalAmount: totalAmount,
                        itemCount: items.length,
                      ),
                    ],
                  ),
            CheckoutSuccess(:final transactionId, :final totalAmount) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle,
                        size: 64, color: Colors.green),
                    const SizedBox(height: 16),
                    Text(
                      'Payment Successful!',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text('Transaction: $transactionId'),
                    Text('Amount: \$${totalAmount.toStringAsFixed(2)}'),
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed: () {
                        context
                            .read<CheckoutBloc>()
                            .add(const LoadCheckoutItems());
                      },
                      child: const Text('New Sale'),
                    ),
                  ],
                ),
              ),
            CheckoutError(:final message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text('Error: $message'),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () {
                        context
                            .read<CheckoutBloc>()
                            .add(const LoadCheckoutItems());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
          };
        },
      ),
    );
  }
}
