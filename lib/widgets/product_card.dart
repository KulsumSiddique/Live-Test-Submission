import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../models/product.dart';
import '../utils/currency.dart';

/// Card showing name, price, category, quantity and +/- buttons.
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();
    final theme = Theme.of(context);
    final quantity = controller.quantityOf(product);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    formatTaka(product.price),
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Chip(
                    label: Text(product.category),
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            IconButton.filledTonal(
              tooltip: 'Decrease quantity',
              icon: const Icon(Icons.remove),
              // Disabled at 0 so quantity can never go negative.
              onPressed: quantity > 0
                  ? () => controller.decreaseQuantity(product)
                  : null,
            ),
            SizedBox(
              width: 36,
              child: Text(
                '$quantity',
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium,
              ),
            ),
            IconButton.filled(
              tooltip: 'Increase quantity',
              icon: const Icon(Icons.add),
              onPressed: () => controller.increaseQuantity(product),
            ),
          ],
        ),
      ),
    );
  }
}
