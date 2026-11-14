import '../models/product.dart';

/// Local product data (no Firebase, REST API or database).
const List<Map<String, dynamic>> _rawProducts = [
  {'name': 'T-Shirt', 'price': 500, 'category': 'Clothes'},
  {'name': 'Shoes', 'price': 1500, 'category': 'Fashion'},
  {'name': 'Watch', 'price': 2000, 'category': 'Accessories'},
  {'name': 'Bag', 'price': 1000, 'category': 'Fashion'},
];

final List<Product> localProducts =
    _rawProducts.map(Product.fromMap).toList(growable: false);

const String allCategories = 'All';

const List<String> categoryOptions = [
  allCategories,
  'Clothes',
  'Fashion',
  'Accessories',
];
