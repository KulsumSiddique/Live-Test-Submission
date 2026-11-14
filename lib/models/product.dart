/// A product in the store. Quantity is kept in the controller, not here,
/// so the product data itself stays constant.
class Product {
  final String name;
  final double price;
  final String category;

  const Product({
    required this.name,
    required this.price,
    required this.category,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] as String,
      price: (map['price'] as num).toDouble(),
      category: map['category'] as String,
    );
  }
}
