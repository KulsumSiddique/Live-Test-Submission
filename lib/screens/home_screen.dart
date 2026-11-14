import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../widgets/cart_summary.dart';
import '../widgets/no_products_found.dart';
import '../widgets/product_card.dart';
import '../widgets/search_filter_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Shopping Cart'),
        centerTitle: true,
        actions: [
          GetBuilder<CartController>(
            builder: (controller) => Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Badge(
                isLabelVisible: controller.totalItems > 0,
                label: Text('${controller.totalItems}'),
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SearchFilterBar(),
          Expanded(
            child: GetBuilder<CartController>(
              builder: (controller) {
                final products = controller.filteredProducts;

                if (products.isEmpty) {
                  return const NoProductsFound();
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: products[index]);
                  },
                );
              },
            ),
          ),
          const CartSummary(),
        ],
      ),
    );
  }
}
