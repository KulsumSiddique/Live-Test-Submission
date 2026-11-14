import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/product_data.dart';
import '../models/product.dart';

/// Holds all app state. Widgets wrapped in GetBuilder<CartController>
/// rebuild whenever update() is called.
class CartController extends GetxController {
  static const double discountThreshold = 3000;
  static const double discountRate = 0.10;

  CartController({List<Product>? products})
      : products = products ?? localProducts;

  final List<Product> products;

  /// Quantity per product, keyed by product name.
  final Map<String, int> _quantities = {};

  final TextEditingController searchTextController = TextEditingController();

  String _searchQuery = '';
  String _selectedCategory = allCategories;

  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;

  // ---------------- Quantity ----------------

  int quantityOf(Product product) => _quantities[product.name] ?? 0;

  void increaseQuantity(Product product) {
    _quantities[product.name] = quantityOf(product) + 1;
    update();
  }

  void decreaseQuantity(Product product) {
    final current = quantityOf(product);
    if (current <= 0) return; // quantity can never go below 0
    _quantities[product.name] = current - 1;
    update();
  }

  // ---------------- Search & filter ----------------

  void updateSearch(String query) {
    _searchQuery = query;
    update();
  }

  void clearSearch() {
    searchTextController.clear();
    updateSearch('');
  }

  void selectCategory(String? category) {
    _selectedCategory = category ?? allCategories;
    update();
  }

  /// Products matching BOTH the search text and the selected category.
  List<Product> get filteredProducts {
    final query = _searchQuery.trim().toLowerCase();

    return products.where((product) {
      final matchesSearch =
          query.isEmpty || product.name.toLowerCase().contains(query);
      final matchesCategory = _selectedCategory == allCategories ||
          product.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  // ---------------- Cart calculation ----------------
  // Totals cover every product in the cart, even ones hidden by the
  // current search or filter.

  int get totalItems =>
      products.fold(0, (sum, product) => sum + quantityOf(product));

  double get subtotal => products.fold(
      0, (sum, product) => sum + product.price * quantityOf(product));

  bool get isDiscountApplied => subtotal >= discountThreshold;

  double get discount => isDiscountApplied ? subtotal * discountRate : 0;

  double get grandTotal => subtotal - discount;

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }
}
