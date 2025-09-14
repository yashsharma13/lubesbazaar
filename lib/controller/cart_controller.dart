import 'package:flutter/material.dart';
import 'package:lubes_bazaar/models/product_model.dart';

class CartController extends ChangeNotifier {
  final List<ProductModel> _cartItems = [];

  List<ProductModel> get cartItems => _cartItems;

  void addToCart(ProductModel product) {
    final index = _cartItems.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      _cartItems[index].quantity += 1;
    } else {
      product.quantity = 1;
      _cartItems.add(product);
    }
    notifyListeners();
  }

  void increaseQuantity(ProductModel product) {
    product.quantity += 1;
    notifyListeners();
  }

  void decreaseQuantity(ProductModel product) {
    if (product.quantity > 1) {
      product.quantity -= 1;
    } else {
      _cartItems.remove(product);
    }
    notifyListeners();
  }

  double get totalPrice {
    return _cartItems.fold(
      0,
      (sum, item) => sum + (double.parse(item.price) * item.quantity),
    );
  }
}
