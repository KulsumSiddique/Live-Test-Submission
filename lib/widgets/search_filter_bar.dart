import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../data/product_data.dart';

/// Search field + category dropdown. They work together because the
/// controller applies both conditions in filteredProducts.
class SearchFilterBar extends StatelessWidget {
  const SearchFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  controller: controller.searchTextController,
                  onChanged: controller.updateSearch,
                  decoration: InputDecoration(
                    hintText: 'Search products',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: controller.searchQuery.isEmpty
                        ? null
                        : IconButton(
                            tooltip: 'Clear search',
                            icon: const Icon(Icons.clear),
                            onPressed: controller.clearSearch,
                          ),
                    border: const OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: controller.selectedCategory,
                      isExpanded: true,
                      items: categoryOptions
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ),
                          )
                          .toList(),
                      onChanged: controller.selectCategory,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
