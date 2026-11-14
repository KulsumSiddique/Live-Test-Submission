import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';

/// Shown when search + category filter match nothing.
class NoProductsFound extends StatelessWidget {
  const NoProductsFound({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.find<CartController>();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off, size: 72, color: theme.colorScheme.outline),
            const SizedBox(height: 12),
            Text('No matching products', style: theme.textTheme.titleLarge),
            const SizedBox(height: 6),
            Text(
              'Try a different name or category.',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.outline),
            ),
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: () {
                controller.clearSearch();
                controller.selectCategory(null);
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Reset filters'),
            ),
          ],
        ),
      ),
    );
  }
}
