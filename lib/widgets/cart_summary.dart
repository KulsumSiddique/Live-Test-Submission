import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../utils/currency.dart';

/// Total Items, Subtotal, Discount and Grand Total.
class CartSummary extends StatelessWidget {
  const CartSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GetBuilder<CartController>(
      builder: (controller) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _SummaryRow(
                  label: 'Total Items',
                  value: '${controller.totalItems}',
                ),
                _SummaryRow(
                  label: 'Subtotal',
                  value: formatTaka(controller.subtotal),
                ),
                _SummaryRow(
                  label: controller.isDiscountApplied
                      ? 'Discount (10%)'
                      : 'Discount',
                  value: '- ${formatTaka(controller.discount)}',
                  valueColor:
                      controller.isDiscountApplied ? Colors.green : null,
                ),
                if (!controller.isDiscountApplied && controller.subtotal > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 2, bottom: 4),
                    child: Text(
                      'Add ${formatTaka(CartController.discountThreshold - controller.subtotal)} '
                      'more to get 10% off',
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                const Divider(),
                _SummaryRow(
                  label: 'Grand Total',
                  value: formatTaka(controller.grandTotal),
                  isBold: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final style = isBold
        ? Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.bold)
        : Theme.of(context).textTheme.bodyMedium;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style?.copyWith(color: valueColor)),
        ],
      ),
    );
  }
}
