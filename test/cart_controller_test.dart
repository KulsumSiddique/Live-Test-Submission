import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_cart/controllers/cart_controller.dart';
import 'package:shopping_cart/models/product.dart';
import 'package:shopping_cart/utils/currency.dart';

void main() {
  late CartController cart;

  setUp(() => cart = CartController());

  Product productNamed(String name) => cart.products.firstWhere((p) => p.name == name);

  test('quantity starts at 0 and cannot go negative', () {
    final shirt = productNamed('T-Shirt');
    expect(cart.quantityOf(shirt), 0);
    cart.decreaseQuantity(shirt);
    expect(cart.quantityOf(shirt), 0);
  });

  test('totals update when quantity changes', () {
    final shirt = productNamed('T-Shirt');
    cart.increaseQuantity(shirt);
    cart.increaseQuantity(shirt);
    expect(cart.totalItems, 2);
    expect(cart.subtotal, 1000);

    cart.decreaseQuantity(shirt);
    expect(cart.totalItems, 1);
    expect(cart.subtotal, 500);
  });

  test('no discount below 3000', () {
    cart.increaseQuantity(productNamed('Watch')); // 2000
    cart.increaseQuantity(productNamed('T-Shirt')); // 500
    expect(cart.subtotal, 2500);
    expect(cart.discount, 0);
    expect(cart.grandTotal, 2500);
  });

  test('10% discount at exactly 3000', () {
    cart.increaseQuantity(productNamed('Watch')); // 2000
    cart.increaseQuantity(productNamed('Bag')); // 1000
    expect(cart.subtotal, 3000);
    expect(cart.discount, 300);
    expect(cart.grandTotal, 2700);
  });

  test('empty search shows all products', () {
    cart.updateSearch('   ');
    expect(cart.filteredProducts.length, 4);
  });

  test('search is case-insensitive', () {
    cart.updateSearch('sHoE');
    expect(cart.filteredProducts.map((p) => p.name), ['Shoes']);
  });

  test('category filter works', () {
    cart.selectCategory('Fashion');
    expect(cart.filteredProducts.map((p) => p.name), ['Shoes', 'Bag']);
  });

  test('search and category filter work together', () {
    cart.selectCategory('Fashion');
    cart.updateSearch('ba');
    expect(cart.filteredProducts.map((p) => p.name), ['Bag']);
  });

  test('no matching products returns empty list', () {
    cart.selectCategory('Clothes');
    cart.updateSearch('watch');
    expect(cart.filteredProducts, isEmpty);
  });

  test('formatTaka formats with commas', () {
    expect(formatTaka(3000), '৳3,000');
    expect(formatTaka(2700.5), '৳2,700.50');
  });
}
