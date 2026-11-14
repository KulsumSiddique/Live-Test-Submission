import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/cart_controller.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const ShoppingCartApp());
}

class ShoppingCartApp extends StatelessWidget {
  const ShoppingCartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Simple Shopping Cart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
      ),
      // Register the controller once for the whole app.
      initialBinding: BindingsBuilder(() {
        Get.put(CartController());
      }),
      home: const HomeScreen(),
    );
  }
}
