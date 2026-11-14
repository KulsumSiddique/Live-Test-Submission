# Simple Shopping Cart (Flutter + GetX)

Browse products, search and filter them, choose quantities and see the cart total.
State is managed with **GetX `GetBuilder` + `update()`**. All data is local.

## Features
- Product cards with name, price, category, quantity and + / − buttons
- Quantity never goes below 0 (− is disabled at 0)
- Cart summary: Total Items, Subtotal, Discount, Grand Total
- 10% discount when the subtotal is ৳3,000 or more
- Case-insensitive search by name
- Category dropdown: All, Clothes, Fashion, Accessories
- Search and category filter work together
- "No matching products" state with a reset button

## Run
```bash
flutter create shopping_cart
# copy lib/, test/, pubspec.yaml, README.md and .gitignore from this repo over the generated ones
rm test/widget_test.dart
flutter pub get
flutter run
flutter test
```

## Structure
```
lib/
├── main.dart                       # GetMaterialApp, registers CartController
├── models/product.dart             # Product model
├── data/product_data.dart          # Local product list + categories
├── controllers/cart_controller.dart# State: quantities, search, filter, totals
├── screens/home_screen.dart        # Scaffold, AppBar, ListView.builder
├── utils/currency.dart             # ৳ formatting
└── widgets/
    ├── search_filter_bar.dart      # TextField + DropdownButton
    ├── product_card.dart           # Card with + / − buttons
    ├── cart_summary.dart           # Totals and discount
    └── no_products_found.dart      # Empty result state
test/cart_controller_test.dart      # Unit tests for all conditions
```
